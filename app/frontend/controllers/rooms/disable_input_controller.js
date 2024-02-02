import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["inputToDisable", "inputUpdateState"];

  connect() {
    this.updateDisableState();
  }

  updateDisableState() {
    const selectedValue = this.inputUpdateStateTargets.find(
      (radio) => radio.checked,
    )?.value; // Adjust based on your input type
    // Check the selected value and disable the input if needed
    const shouldDisable = selectedValue !== "main";

    this.inputToDisableTarget.disabled = shouldDisable;
  }
}
