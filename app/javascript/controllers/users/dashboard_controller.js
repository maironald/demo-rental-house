import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { check: Boolean };

  connect() {
    this.checkValueChanged();
  }


  connect() {
    this.navLinks().forEach((link) => {
      link.addEventListener("click", this.handleClick.bind(this));
    });
  }

  handleClick(event) {
    event.preventDefault();
    const clickedLink = event.target;
    this.clearActiveClass();
    location.href = clickedLink.getAttribute("href");
    clickedLink.classList.add("active");
  }

  clearActiveClass() {
    this.navLinks().forEach((link) => {
      link.classList.remove("active");
    });
  }

  navLinks() {
    return this.element.querySelectorAll(".nav-side-menu li a");
  }
}
