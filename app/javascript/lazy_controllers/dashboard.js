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

Stimulus.register("dashboard", class extends Controller {
  static targets = [ "cardChart" ];

  connect() {
    this.cardChart = new Chart(this.cardChartTarget, {
      type: 'line',
      data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [
          {
            label: 'My First dataset',
            backgroundColor: 'transparent',
            borderColor: 'rgba(255,255,255,.55)',
            pointBackgroundColor: coreui.Utils.getStyle('--cui-primary'),
            data: [65, 59, 84, 84, 51, 55, 40]
          }
        ]
      },
      options: options
    });
  }
});
