import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "list"];
  connect() {
    if (this.hasListTarget) {
    }
  }
  toggle() {
    this.listTarget.classList.remove("hidden");
  }
}
