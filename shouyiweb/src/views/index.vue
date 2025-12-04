<template>
  <div class="p-4 sm:p-6 lg:p-8">
    <div class="max-w-7xl mx-auto">
      <!-- 顶部欢迎语 -->
      <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-800">{{ greeting }}, 管理员!</h1>
        <p class="text-gray-500 mt-1">这是您的项目实时数据概览。</p>
      </div>

      <!-- 第一行：数据统计卡片 -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- 卡片1: 访问量 -->
        <div class="card flex items-center">
          <div class="p-3 bg-indigo-100 rounded-xl">
            <Eye class="w-8 h-8 text-indigo-500" />
          </div>
          <div class="ml-4">
            <p class="text-gray-500 text-sm">今日访问量</p>
            <p class="text-2xl font-bold text-gray-800">12,426</p>
          </div>
        </div>
        <!-- 卡片2: 收入 -->
        <div class="card flex items-center">
          <div class="p-3 bg-green-100 rounded-xl">
            <DollarSign class="w-8 h-8 text-green-500" />
          </div>
          <div class="ml-4">
            <p class="text-gray-500 text-sm">本月上报数据</p>
            <p class="text-2xl font-bold text-gray-800">86,520</p>
          </div>
        </div>
        <!-- 卡片3: 新用户 -->
        <div class="card flex items-center">
          <div class="p-3 bg-orange-100 rounded-xl">
            <Users class="w-8 h-8 text-orange-500" />
          </div>
          <div class="ml-4">
            <p class="text-gray-500 text-sm">本周新用户</p>
            <p class="text-2xl font-bold text-gray-800">1,275</p>
          </div>
        </div>
        <!-- 卡片4: 消息 -->
        <div class="card flex items-center">
          <div class="p-3 bg-rose-100 rounded-xl">
            <Mail class="w-8 h-8 text-rose-500" />
          </div>
          <div class="ml-4">
            <p class="text-gray-500 text-sm">待处理消息</p>
            <p class="text-2xl font-bold text-gray-800">98</p>
          </div>
        </div>
      </div>

      <!-- 第二行：主要图表 -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
        <!-- 左侧：销售趋势折线图 -->
        <div class="card lg:col-span-2">
          <h2 class="text-xl font-semibold text-gray-700 mb-4">近半年销售趋势</h2>
          <div ref="salesChartDom" style="width: 100%; height: 400px;"></div>
        </div>
        <!-- 右侧：流量来源饼图 -->
        <div class="card">
          <h2 class="text-xl font-semibold text-gray-700 mb-4">流量来源分布</h2>
          <div ref="trafficSourceChartDom" style="width: 100%; height: 400px;"></div>
        </div>
      </div>

      <!-- 第三行：其他信息 -->
      <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
        <!-- 最新动态 -->
        <div class="card md:col-span-1 xl:col-span-1">
          <h2 class="text-xl font-semibold text-gray-700 mb-4">最新动态</h2>
          <div class="space-y-5">
            <div class="flex items-start">
              <div class="flex-shrink-0 pt-1">
                <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center">
                  <ShoppingCart class="w-5 h-5 text-blue-500" />
                </div>
              </div>
              <div class="ml-3">
                <p class="text-sm text-gray-800">用户 <span class="font-medium">lily</span> 完成了一笔新订单 (#20240917)</p>
                <p class="text-xs text-gray-500">2分钟前</p>
              </div>
            </div>
            <div class="flex items-start">
              <div class="flex-shrink-0 pt-1">
                <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center">
                  <UserPlus class="w-5 h-5 text-green-500" />
                </div>
              </div>
              <div class="ml-3">
                <p class="text-sm text-gray-800">新用户 <span class="font-medium">吴洋</span> 刚刚注册成功</p>
                <p class="text-xs text-gray-500">15分钟前</p>
              </div>
            </div>
            <div class="flex items-start">
              <div class="flex-shrink-0 pt-1">
                <div class="w-8 h-8 rounded-full bg-red-100 flex items-center justify-center">
                  <AlertCircle class="w-5 h-5 text-red-500" />
                </div>
              </div>
              <div class="ml-3">
                <p class="text-sm text-gray-800">服务器 <span class="font-medium">#3</span> 磁盘空间达到预警阈值</p>
                <p class="text-xs text-gray-500">45分钟前</p>
              </div>
            </div>
            <div class="flex items-start">
              <div class="flex-shrink-0 pt-1">
                <div class="w-8 h-8 rounded-full bg-indigo-100 flex items-center justify-center">
                  <FileCheck class="w-5 h-5 text-indigo-500" />
                </div>
              </div>
              <div class="ml-3">
                <p class="text-sm text-gray-800">文件 <span class="font-medium">"Q3季度报告.pdf"</span> 已成功上传</p>
                <p class="text-xs text-gray-500">1小时前</p>
              </div>
            </div>
            <div class="flex items-start">
              <div class="flex-shrink-0 pt-1">
                <div class="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center">
                  <Settings class="w-5 h-5 text-purple-500" />
                </div>
              </div>
              <div class="ml-3">
                <p class="text-sm text-gray-800">系统设置已更新：关闭了维护模式</p>
                <p class="text-xs text-gray-500">2小时前</p>
              </div>
            </div>
          </div>
        </div>
        <!-- 用户活动地域分布 -->
        <div class="card xl:col-span-2">
          <h2 class="text-xl font-semibold text-gray-700 mb-4">用户活动地域分布</h2>
          <div ref="userMapChartDom" style="width: 100%; height: 300px;"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, nextTick } from 'vue';
import * as echarts from 'echarts';
import {
  Eye,
  DollarSign,
  Users,
  Mail,
  ShoppingCart,
  UserPlus,
  AlertCircle,
  FileCheck,
  Settings
} from 'lucide-vue-next';


// 从全局对象 `window` 中获取库，如果它们是通过 CDN 引入的
// const echarts = window.echarts;
// const lucide = window.lucide;

// --- 响应式数据 ---
const greeting = ref('');
const salesChartDom = ref(null);
const trafficSourceChartDom = ref(null);
const userMapChartDom = ref(null);

let salesChart = null;
let trafficSourceChart = null;
let userMapChart = null;


// --- 方法 ---

// 设置动态问候语
const setGreeting = () => {
  const currentHour = new Date().getHours();
  if (currentHour < 12) {
    greeting.value = '早上好';
  } else if (currentHour < 14) {
    greeting.value = '中午好';
  } else if (currentHour < 18) {
    greeting.value = '下午好';
  } else {
    greeting.value = '晚上好';
  }
};

// 初始化销售趋势图
const initSalesChart = () => {
  salesChart = echarts.init(salesChartDom.value);
  const option = {
    tooltip: { trigger: 'axis' },
    legend: { data: ['电子产品', '服装', '家居用品'] },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: ['一月', '二月', '三月', '四月', '五月', '六月']
    },
    yAxis: { type: 'value' },
    series: [
      { name: '电子产品', type: 'line', smooth: true, data: [120, 132, 101, 134, 90, 230] },
      { name: '服装', type: 'line', smooth: true, data: [220, 182, 191, 234, 290, 330] },
      { name: '家居用品', type: 'line', smooth: true, data: [150, 232, 201, 154, 190, 330] }
    ]
  };
  salesChart.setOption(option);
};

// 初始化流量来源图
const initTrafficSourceChart = () => {
  trafficSourceChart = echarts.init(trafficSourceChartDom.value);
  const option = {
    tooltip: { trigger: 'item' },
    legend: { top: '5%', left: 'center' },
    series: [
      {
        name: '来源',
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        itemStyle: { borderRadius: 10, borderColor: '#fff', borderWidth: 2 },
        label: { show: false, position: 'center' },
        emphasis: { label: { show: true, fontSize: '20', fontWeight: 'bold' } },
        labelLine: { show: false },
        data: [
          { value: 1048, name: '搜索引擎' },
          { value: 735, name: '直接访问' },
          { value: 580, name: '社交媒体' },
          { value: 484, name: '广告' },
          { value: 300, name: '其他' }
        ]
      }
    ]
  };
  trafficSourceChart.setOption(option);
};

// 初始化用户地域分布图
const initUserMapChart = () => {
    userMapChart = echarts.init(userMapChartDom.value);
    const option = {
        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
        grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
        xAxis: { type: 'value', boundaryGap: [0, 0.01] },
        yAxis: { type: 'category', data: ['北京', '上海', '广东', '江苏', '浙江', '四川'] },
        series: [{ name: '活跃用户数', type: 'bar', data: [18203, 23489, 29034, 104970, 131744, 630230] }]
    };
    userMapChart.setOption(option);
};


// 图表自适应
const resizeCharts = () => {
    salesChart?.resize();
    trafficSourceChart?.resize();
    userMapChart?.resize();
}

// --- 生命周期钩子 ---
onMounted(() => {
  setGreeting();

  // 初始化所有图表
  initSalesChart();
  initTrafficSourceChart();
  initUserMapChart();

  // 渲染图标
  // 使用 nextTick 确保 DOM 已经更新完毕
  // nextTick(() => {
  //   lucide?.createIcons();
  // });

  // 监听窗口大小变化
  window.addEventListener('resize', resizeCharts);
});

onBeforeUnmount(() => {
    // 销毁图表实例并移除监听器
    salesChart?.dispose();
    trafficSourceChart?.dispose();
    userMapChart?.dispose();
    window.removeEventListener('resize', resizeCharts);
})

</script>

<style scoped>
body {
  /* 在 scoped style 中，这个 body 规则不会生效，应该将背景色设置在组件的根元素或全局样式中 */
  /* 例如，可以在 src/style.css 中设置 body { background-color: #f0f2f5; } */
}
.card {
  background-color: white;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}
</style>
