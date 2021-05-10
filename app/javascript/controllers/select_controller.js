import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "dropdown" ]

  toggle(event) {
    event.preventDefault();

    if (this.dropdownTarget.classList.value.includes("hidden")) {
      this.dropdownTarget.classList.add('block');
      this.dropdownTarget.classList.remove('hidden');
    } else {
      this.dropdownTarget.classList.remove('block');
      this.dropdownTarget.classList.add('hidden');
    }
  }
}
