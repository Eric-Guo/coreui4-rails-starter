import { Controller } from "@hotwired/stimulus"

const options = {
  plugins: {
    legend: {
      display: false
    }
  },
  maintainAspectRatio: false,
  scales: {
    x: {
      grid: {
        display: false,
        drawBorder: false
      },
      ticks: {
        display: false
      }
    },
    y: {
      min: 30,
      max: 89,
      display: false,
      grid: {
        display: false
      },
      ticks: {
        display: false
      }
    }
  },
  elements: {
    line: {
      borderWidth: 1,
      tension: 0.4
    },
    point: {
      radius: 4,
      hitRadius: 10,
      hoverRadius: 4
    }
  }
}

export default class extends Controller {
  static targets = ["cardChart"]
  static values = {
    title: String,
    labels: Array,
    data: Array
  }

  async connect() {
    this.connected = true
    const [{ default: Chart }, { getStyle }] = await Promise.all([
      import("chart.js/auto"),
      import("@coreui/utils")
    ])
    if (!this.connected) return

    this.cardChart = new Chart(this.cardChartTarget, {
      type: "line",
      data: {
        labels: this.labelsValue,
        datasets: [
          {
            label: this.titleValue,
            backgroundColor: "transparent",
            borderColor: "rgba(255,255,255,.55)",
            pointBackgroundColor: getStyle("--cui-primary"),
            data: this.dataValue
          }
        ]
      },
      options
    })
    this.element.dataset.chartInitialized = "true"
  }

  disconnect() {
    this.connected = false
    this.cardChart?.destroy()
  }
}
