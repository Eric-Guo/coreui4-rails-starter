import { Controller } from "@hotwired/stimulus"
import { loadSelectize } from "../selectize"

export default class extends Controller {
  static targets = ["select"]

  async connect() {
    this.connected = true
    const $ = await loadSelectize()
    if (!this.connected) return

    this.selectize = $(this.selectTarget).selectize({
      plugins: ["remove_button"]
    })[0].selectize
  }

  disconnect() {
    this.connected = false
    this.selectize?.destroy()
  }
}
