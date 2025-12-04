package org.dromara.reporting.utils;

import cn.hutool.core.util.StrUtil;
import cn.idev.excel.FastExcel;
import cn.idev.excel.context.AnalysisContext;
import cn.idev.excel.read.listener.ReadListener;
import lombok.extern.slf4j.Slf4j;
import org.dromara.common.core.exception.ServiceException;
import org.dromara.reporting.domain.bo.NursingReportDataImportVo;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 自定义Excel解析器
 * 用于解析护理医院端数据填报模板的特殊格式
 *
 * @author ruoyi
 * @date 2025-09-16
 */
@Slf4j
public class CustomExcelParser {

    /**
     * 解析护理医院端数据填报Excel模板
     *
     * @param inputStream Excel文件输入流
     * @return 解析后的数据列表
     */
    public static List<NursingReportDataImportVo> parseNursingReportTemplate(InputStream inputStream) {
        NursingReportTemplateListener listener = new NursingReportTemplateListener();

        try {
            FastExcel.read(inputStream)
                .registerReadListener(listener)
                .sheet()
                .doRead();

            return listener.getResult();

        } catch (Exception e) {
            log.error("解析Excel失败", e);
            throw new ServiceException("解析Excel失败：" + e.getMessage());
        }
    }

    /**
     * 自定义Excel读取监听器
     */
    private static class NursingReportTemplateListener implements ReadListener<Map<Integer, String>> {

        private final List<NursingReportDataImportVo> result = new ArrayList<>();
        private Integer reportYear;
        private Integer reportSeason;
        private ColumnMapping columnMapping;
        private boolean isHeaderParsed = false;
        // 用于存储上一行的数据，处理合并单元格情况
        private Map<Integer, String> previousRowData = new HashMap<>();

        @Override
        public void invoke(Map<Integer, String> data, AnalysisContext context) {
            int rowIndex = context.readRowHolder().getRowIndex();

            // 处理合并单元格的情况，如果当前行某个单元格为空，但上一行相同列有值，则使用上一行的值
            handleMergedCells(data);

            // 第3行（索引2）：解析年份季度信息
            if (rowIndex == 2) {
                parseYearSeasonFromA3(data);
                return;
            }

            // 第5行（索引4）：解析标题行
            if (rowIndex == 4) {
                parseHeaderRow(data);
                isHeaderParsed = true;
                return;
            }

            // 第6行及以后：解析数据行
            if (rowIndex >= 5 && isHeaderParsed && columnMapping != null) {
                List<NursingReportDataImportVo> rowData = parseDataRow(data);
                result.addAll(rowData);
            }

            // 保存当前行数据供下一行使用
            previousRowData.clear();
            previousRowData.putAll(data);
        }

        @Override
        public void doAfterAllAnalysed(AnalysisContext context) {
            log.info("Excel解析完成，共解析{}条数据", result.size());
        }

        public List<NursingReportDataImportVo> getResult() {
            return result;
        }

        /**
         * 处理合并单元格的情况
         * 当某个单元格为空，但上一行相同列有值时，使用上一行的值
         * @param data 当前行数据
         */
        private void handleMergedCells(Map<Integer, String> data) {
            if (previousRowData != null && !previousRowData.isEmpty()) {
                for (Map.Entry<Integer, String> entry : previousRowData.entrySet()) {
                    Integer colIndex = entry.getKey();
                    String previousValue = entry.getValue();

                    // 如果当前行该列为空，但上一行该列有值，则使用上一行的值
                    if (colIndex<2 && data.get(colIndex) == null && previousValue != null) {
                        data.put(colIndex, previousValue);
                    }
                }
            }
        }

        /**
         * 从A3单元格解析年份和季度信息
         */
        private void parseYearSeasonFromA3(Map<Integer, String> data) {
            String timeStr = data.get(0); // A列，索引0
            if (StrUtil.isBlank(timeStr)) {
                throw new ServiceException("A3单元格不能为空，请确保格式为'YYYY年X季度'");
            }

            Integer[] yearAndSeason = parseYearAndSeason(timeStr);
            this.reportYear = yearAndSeason[0];
            this.reportSeason = yearAndSeason[1];

            log.info("解析到年份季度信息：{}年{}季度", reportYear, reportSeason);
        }

        /**
         * 解析标题行
         */
        private void parseHeaderRow(Map<Integer, String> data) {
            this.columnMapping = new ColumnMapping();

            for (Map.Entry<Integer, String> entry : data.entrySet()) {
                int colIndex = entry.getKey();
                String cellValue = StrUtil.nullToEmpty(entry.getValue()).trim();

                // 根据标题内容确定列的类型
                if ("分类序号".equals(cellValue)) {
                    columnMapping.categorySequenceCol = colIndex;
                } else if ("分类名称".equals(cellValue) || "分类".equals(cellValue)) {
                    columnMapping.categoryNameCol = colIndex;
                } else if (cellValue.contains("指标编码") || cellValue.contains("indicator_code") || "变量".equals(cellValue)) {
                    // 如果是"变量"列，可能包含指标编码
                    columnMapping.addIndicatorCodeCol(colIndex);
                } else if (cellValue.contains("指标名称") || cellValue.contains("indicator_name")) {
                    columnMapping.addIndicatorNameCol(colIndex);
                } else if (cellValue.contains("变量值") || cellValue.contains("data_value") || "变量值".equals(cellValue)) {
                    columnMapping.addDataValueCol(colIndex);
                }
            }

            // 验证必要的列是否存在
            if (columnMapping.categoryNameCol == -1) {
                throw new ServiceException("找不到'分类名称'列");
            }

            log.info("解析到列映射：{}", columnMapping);
        }

        /**
         * 解析数据行
         */
        private List<NursingReportDataImportVo> parseDataRow(Map<Integer, String> data) {
            List<NursingReportDataImportVo> rowResult = new ArrayList<>();

            // 获取分类名称
            String categoryName = data.get(columnMapping.categoryNameCol);
            if (StrUtil.isBlank(categoryName)) {
                return rowResult; // 如果分类名称为空，跳过这一行
            }

            // 获取分类序号（如果有）
            String categorySequence = "";
            if (columnMapping.categorySequenceCol != -1) {
                categorySequence = StrUtil.nullToEmpty(data.get(columnMapping.categorySequenceCol));
            }

            // 处理指标编码和数据值的配对
            // 假设指标编码和数据值是成对出现的
            int maxPairs = Math.max(columnMapping.indicatorCodeCols.size(),
                                  columnMapping.dataValueCols.size());

            for (int i = 0; i < maxPairs; i++) {
                String indicatorCode = "";
                String indicatorName = "";
                String dataValueStr = "";

                // 获取指标编码
                if (i < columnMapping.indicatorCodeCols.size()) {
                    indicatorCode = StrUtil.nullToEmpty(data.get(columnMapping.indicatorCodeCols.get(i)));
                    indicatorName = StrUtil.nullToEmpty(data.get(columnMapping.indicatorCodeCols.get(i)+1));
                }

                // 获取数据值
                if (i < columnMapping.dataValueCols.size()) {
                    dataValueStr = StrUtil.nullToEmpty(data.get(columnMapping.dataValueCols.get(i)));
                }

                // 如果指标编码为空，跳过
                if (StrUtil.isBlank(indicatorCode)) {
                    continue;
                }

                // 创建导入VO对象
                NursingReportDataImportVo importVo = new NursingReportDataImportVo();
                importVo.setCategoryName(categoryName);
                importVo.setIndicatorCode(indicatorCode);
                importVo.setIndicatorName(indicatorName); // 暂时使用编码作为名称
                importVo.setReportYear(reportYear);
                importVo.setReportSeason(reportSeason);

                // 解析数据值
                if (StrUtil.isNotBlank(dataValueStr)) {
                    try {
                        // 清理数据值中的非数字字符（除了小数点和负号）
                        String cleanValue = dataValueStr.replaceAll("[^\\d.-]", "");
                        if (StrUtil.isNotBlank(cleanValue)) {
                            BigDecimal dataValue = new BigDecimal(cleanValue);
                            importVo.setDataValue(dataValue);
                        }
                    } catch (NumberFormatException e) {
                        log.warn("数据值格式不正确，跳过：{}", dataValueStr);
                        continue;
                    }
                }

                // 设置排序号（基于分类序号）
                if (StrUtil.isNotBlank(categorySequence)) {
                    try {
                        importVo.setOrderNum(Integer.parseInt(categorySequence));
                    } catch (NumberFormatException e) {
                        // 忽略序号解析错误
                    }
                }

                rowResult.add(importVo);
            }

            return rowResult;
        }
    }

    /**
     * 解析年份和季度信息
     * 支持格式：2025年2季度、2025年第2季度等
     */
    private static Integer[] parseYearAndSeason(String timeStr) {
        if (StrUtil.isBlank(timeStr)) {
            throw new ServiceException("时间信息不能为空");
        }

        // 使用正则表达式提取年份和季度
        Pattern pattern = Pattern.compile("(\\d{4})年.*?(\\d)季度");
        Matcher matcher = pattern.matcher(timeStr);

        if (!matcher.find()) {
            throw new ServiceException("时间格式不正确，请使用'YYYY年X季度'格式，如：2025年2季度");
        }

        Integer year = Integer.parseInt(matcher.group(1));
        Integer season = Integer.parseInt(matcher.group(2));

        if (season < 1 || season > 4) {
            throw new ServiceException("季度必须是1-4之间的数字");
        }

        return new Integer[]{year, season};
    }

    /**
     * 列映射信息
     */
    private static class ColumnMapping {
        int categorySequenceCol = -1; // 分类序号列
        int categoryNameCol = -1;     // 分类名称列
        List<Integer> indicatorCodeCols = new ArrayList<>();  // 指标编码列（可能有多列）
        List<Integer> indicatorNameCols = new ArrayList<>();  // 指标名称列（可能有多列）
        List<Integer> dataValueCols = new ArrayList<>();      // 数据值列（可能有多列）

        void addIndicatorCodeCol(int col) {
            indicatorCodeCols.add(col);
        }

        void addIndicatorNameCol(int col) {
            indicatorNameCols.add(col);
        }

        void addDataValueCol(int col) {
            dataValueCols.add(col);
        }

        @Override
        public String toString() {
            return String.format("ColumnMapping{categorySequence=%d, categoryName=%d, indicatorCode=%s, indicatorName=%s, dataValue=%s}",
                    categorySequenceCol, categoryNameCol, indicatorCodeCols, indicatorNameCols, dataValueCols);
        }
    }
}
