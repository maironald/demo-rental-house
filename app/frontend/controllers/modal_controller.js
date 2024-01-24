import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log("Modal connected");
  }

  open() {
    this.modalTarget.style.display = "block";
  }

  close() {
    this.modalTarget.style.display = "none";
  }
}
