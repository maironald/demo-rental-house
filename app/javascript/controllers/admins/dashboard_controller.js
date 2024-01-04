import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['priceContent'];

  connect() {
    let a = 'aaaa';
    console.log(
      "🚀 ~ file: dashboard_controller.js:7 ~ extends ~ connect ~ a = 'aaaa' :",
      a
    );
  }

  showPriceContent(event) {
    if (this.priceContentTarget.classList.contains('hidden')) {
      this.priceContentTarget.classList.remove('hidden');
      event.target.textContent = 'Hide Price Content';
    } else {
      this.priceContentTarget.classList.add('hidden');
      event.target.textContent = 'Show Price Content';
    }
  }
}
