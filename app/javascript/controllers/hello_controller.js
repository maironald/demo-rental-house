import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    debugger;
    this.element.textContent = 'Hello World!';
  }
}
