import { Controller } from "@hotwired/stimulus"
import { Sidebar } from "@coreui/coreui-pro"
import { put } from "@rails/request.js"

export default class extends Controller {
  toggle() {
    const sidebar = Sidebar.getOrCreateInstance(this.element)
    sidebar.toggleUnfoldable()
    const unfoldable = this.element.classList.contains("sidebar-narrow-unfoldable")
    put("/account/profile.json", { body: { sidebar_unfoldable: unfoldable } })
  }
}
