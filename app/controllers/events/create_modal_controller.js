import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.toggleModal();
    console.log(1);
  }

  toggleModal() {
    console.log(this.data);
    fetch(this.data.get("url"), { method: "GET" })
      .then((response) => response.text())
      .then((data) => {
        this.getElementById("modal-body").innerHTML = data.html;
        this.modalBodyTarget.classList.remove("hidden");
      });
  }

  test() {
    console.log(1111);
  }
}
