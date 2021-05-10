import { Controller } from "stimulus"

export default class extends Controller {
  static values = { replyId: Number };

  openReply(event) {
    event.stopPropagation();
    const modalController = this.application.getControllerForElementAndIdentifier(
      document.getElementById(`feedback-reply-${this.replyIdValue}`),
      "modal"
    );
    if (modalController) {
      modalController.open();
    }
  }

  openOne2one(event) {
    event.stopPropagation();
    const modalController = this.application.getControllerForElementAndIdentifier(
      document.getElementById(`one2one-${this.replyIdValue}`),
      "modal"
    );
    if (modalController) {
      modalController.open();
    }
  }
}
