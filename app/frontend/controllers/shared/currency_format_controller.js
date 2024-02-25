/* eslint-disable no-param-reassign */
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.formatCurrency.bind(this));
  }

  formatCurrency(event) {
    const value = event.target.value.replace(/\D/g, "");
    const formattedValue = new Intl.NumberFormat("vi-VN", {
      minimumFractionDigits: 0,
    }).format(value);

    event.target.value = formattedValue;
  }
}
