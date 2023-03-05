import Chart from 'chart.js/auto';
global.Chart = Chart;
coreui.ChartJS ||= {}
coreui.ChartJS.customTooltips = require("@coreui/chartjs").customTooltips;
coreui.Utils = require("@coreui/utils")
require("lazy_controllers/dashboard");
