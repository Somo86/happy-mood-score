import { Controller } from "stimulus"

export default class extends Controller {
  static values = { info: Object };

  connect() {
    this.canvas = document.getElementById(this.infoValue['id']);
    this.createGraph();
  }

  createGraph() {
    const chart = new Chart(this.canvas, {
      type: 'doughnut',
      data: {
        labels: this.infoValue['labels'],
        datasets: [{
          data: this.infoValue['data'],
          backgroundColor: this.infoValue['colour'],
        }],
      },
      options: {
        plugins: {
          tooltip: {
            enabled: false,
          },
        },
        rotation: -90,
        circumference: 180,
        animation: {
          onComplete: () => {
            this.drawNeedle(75, this.infoValue['needle']);
          }
        }
      }
    });
  }

  drawNeedle(radius, radianAngle) {
    const ctx = this.canvas.getContext('2d');
    const cw = this.canvas.offsetWidth;
    const ch = this.canvas.offsetHeight;
    const cx = cw / 2;
    const cy = ch - (ch / 4);

    ctx.translate(cx, cy);
    ctx.rotate(radianAngle);
    ctx.beginPath();
    ctx.moveTo(0, -5);
    ctx.lineTo(radius, 0);
    ctx.lineTo(0, 5);
    ctx.fillStyle = 'rgba(0, 76, 0, 0.8)';
    ctx.fill();
    ctx.rotate(-radianAngle);
    ctx.translate(-cx, -cy);
    ctx.beginPath();
    ctx.arc(cx, cy, 7, 0, Math.PI * 2);
    ctx.fill();
  }
}
