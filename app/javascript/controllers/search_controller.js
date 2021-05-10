import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "query" ];

  update(event) {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.queryTarget.requestSubmit();
    }, 400)
  }
}
