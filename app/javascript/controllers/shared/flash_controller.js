import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['alert'];

  connect() {
    setTimeout(() => {
      this.alertTarget.close();
    }, 3000);
  }
}
