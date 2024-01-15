import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['alert'];

  connect() {
    setTimeout(() => {
      this.closeAlert();
    }, 3000);
  }
  closeAlert() {
    // Set display to "none" or remove the element from the DOM
    this.alertTarget.style.display = 'none';
    // Alternatively, if you want to remove the element from the DOM
    // this.alertTarget.remove();
  }
}
