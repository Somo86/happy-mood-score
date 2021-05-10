import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "select" ];

  connect() {
    this.updateFrequency(document.getElementById('company_frequency').value);
  }

  update(event) {
    this.updateFrequency(event.target.value);
  }

  updateFrequency(newFrequency) {
    if (newFrequency === "daily") {
      this.selectTarget.classList.remove('block');
      this.selectTarget.classList.add('hidden');
    } else {
      this.selectTarget.classList.add('block');
      this.selectTarget.classList.remove('hidden');
    }
  }
}
