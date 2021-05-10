import { Controller } from "stimulus"

export default class extends Controller {
  static values = { info: Object };

  connect() {
    this.createGraph();
  }

  createGraph() {
    const ctx = document.getElementById(this.infoValue['id']);

    new Chart(ctx, {
      type: 'line',
      data: this.infoValue['data']
    });
  }
}
