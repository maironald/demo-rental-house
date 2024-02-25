import { Controller } from "@hotwired/stimulus";
import { Dismiss } from 'flowbite';

export default class extends Controller {
  static targets = ["alert"];


  connect() {
    const dismiss = new Dismiss(this.alertTarget);

    setTimeout(() => {
      dismiss.hide()
    }, 3000);
  }
}
