import { Controller } from "@hotwired/stimulus"
import { loadSelectize } from "../selectize"

export default class extends Controller {
  async connect() {
    this.connected = true
    const $ = await loadSelectize()
    if (!this.connected) return

    const select = this.element.querySelector("#user-ids-select")
    if (!select) return

    this.selectize = $(select).selectize({
      plugins: ["remove_button"],
      respect_word_boundaries: false,
      valueField: "id",
      labelField: "name",
      searchField: "name",
      create: false,
      load(query, callback) {
        if (!query.length) return callback()

        $.ajax({
          url: `/ui/user_select.json?q=${encodeURIComponent(query)}`,
          type: "GET",
          error() {
            callback()
          },
          success(result) {
            callback(result.users)
          }
        })
      }
    })[0].selectize
  }

  disconnect() {
    this.connected = false
    this.selectize?.destroy()
  }
}
