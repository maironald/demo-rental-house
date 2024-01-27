import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  connect() {
    console.log("Connected to filter controller");
  }

  handleChange(event) {
    const selectedValue = event.target.value;
    Turbo.visit(`/users/rooms/?selected_value=${selectedValue}`, {
      action: "replace",
    });
    console.log(selectedValue);
  }
}
