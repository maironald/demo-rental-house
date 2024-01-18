import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    this.element.classList.add('clickable');
  }

  click(event) {
    event.preventDefault();
    const href = this.element.getAttribute('data-link');

    if (href) {
      window.location.href = href;
    }
  }
}
