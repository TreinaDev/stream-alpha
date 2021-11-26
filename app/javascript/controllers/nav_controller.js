import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button1", "button2", "drop1", "drop2"];
  connect() {
    if (this.hasListTarget) {
    }
  }
  toggle() {
    console.log(this.drop1Target.classList);
    if (this.drop1Target.classList.contains("hidden")) {
      this.drop1Target.classList.remove("hidden");
    } else {
      this.drop1Target.classList.add("hidden");
    }
    this.drop2Target.classList.add("hidden");
  }
  toggle_drop() {
    if (this.drop2Target.classList.contains("hidden")) {
      this.drop2Target.classList.remove("hidden");
    } else {
      this.drop2Target.classList.add("hidden");
    }
    this.drop1Target.classList.add("hidden");
  }
}
