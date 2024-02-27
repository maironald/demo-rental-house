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

    this.inputToDisableTargets.forEach((input) => {
      // eslint-disable-next-line no-param-reassign
      input.disabled = shouldDisable;
      // eslint-disable-next-line no-param-reassign
      input.value = shouldDisable ? "0" : ""; // Set value to "0" if shouldDisable is true, otherwise set an empty string
    });
  }
}
