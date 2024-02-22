import { Controller } from "@hotwired/stimulus";
import { Dismiss } from 'flowbite';

export default class extends Controller {
  static targets = ["alert"];

  initialize() {
    const dismiss = new Dismiss(this.alertTarget);
    dismiss.hide()
  }

  connect() {
    // const dismiss = new Dismiss(this.alertTarget);
    // this.closeAlert()

    setTimeout(() => {
      this.closeAlert();
      // dismiss.hide()
    }, 3000);
  }

  closeAlert() {
    // Set display to "none" or remove the element from the DOM
    this.alertTarget.style.display = "none";
    // Alternatively, if you want to remove the element from the DOM
    // this.alertTarget.remove();
  }
}
