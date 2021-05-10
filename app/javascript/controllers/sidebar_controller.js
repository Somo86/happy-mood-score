import { Controller } from "stimulus";

export default class extends Controller {
  static classes = ["show", "hide"];
  static targets = [ "menu", "userMenu", "userMenuLayout" ]

  connect() {
    this.menuTarget.classList.add(this.hideClass);
  }

  toggle(event) {
    event.preventDefault();
    if (this.menuTarget.classList.value === "hidden") {
      this.menuTarget.classList.add(this.showClass);
      this.menuTarget.classList.remove(this.hideClass);
    } else {
      this.menuTarget.classList.remove(this.showClass);
      this.menuTarget.classList.add(this.hideClass);
    }
  }

  toggleUserMenu(event) {
    event.preventDefault();
    if (this.userMenuTarget.classList.value.includes("hidden")) {
      this.userMenuTarget.classList.add(this.showClass);
      this.userMenuTarget.classList.remove(this.hideClass);
      this.userMenuLayoutTarget.classList.add(this.showClass);
      this.userMenuLayoutTarget.classList.remove(this.hideClass);
    } else {
      this.userMenuTarget.classList.remove(this.showClass);
      this.userMenuTarget.classList.add(this.hideClass);
      this.userMenuLayoutTarget.classList.remove(this.showClass);
      this.userMenuLayoutTarget.classList.add(this.hideClass);
    }
  }
}
