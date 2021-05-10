import { Controller } from "stimulus";

export default class extends Controller {
  static classes = ["show", "hide"];
  static targets = [ "menu", "down", "left" ]

  connect() {
    this.menuTarget.classList.add(this.hideClass);
  }

  toggle(event) {
    event.preventDefault();
    if (this.menuTarget.classList.value === "hidden") {
      this.menuTarget.classList.add(this.showClass);
      this.menuTarget.classList.remove(this.hideClass);
      this.downTarget.classList.add(this.showClass);
      this.downTarget.classList.remove(this.hideClass);
      this.leftTarget.classList.add(this.hideClass);
      this.leftTarget.classList.remove(this.showClass);
    } else {
      this.menuTarget.classList.remove(this.showClass);
      this.menuTarget.classList.add(this.hideClass);
      this.downTarget.classList.remove(this.showClass);
      this.downTarget.classList.add(this.hideClass);
      this.leftTarget.classList.add(this.showClass);
      this.leftTarget.classList.remove(this.hideClass);
    }
  }
}
