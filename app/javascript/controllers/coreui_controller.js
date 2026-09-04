import { Controller } from "@hotwired/stimulus"
import {
  Navigation,
  Popover,
  Sidebar,
  Tooltip
} from "@coreui/coreui-pro"

const COMPONENTS = [
  ['[data-coreui="navigation"], [data-coreui-navigation]', Navigation],
  [".sidebar", Sidebar],
  ['[data-coreui-toggle="popover"]', Popover],
  ['[data-coreui-toggle="tooltip"]', Tooltip]
]

export default class extends Controller {
  connect() {
    COMPONENTS.forEach(([selector, Component]) => {
      this.element.querySelectorAll(selector).forEach((element) => {
        Component.getOrCreateInstance(element)
      })
    })
  }

  toggleSidebar(event) {
    const selector = event.currentTarget.dataset.coreuiTarget || "#sidebar"
    const sidebar = document.querySelector(selector)
    if (sidebar) Sidebar.getOrCreateInstance(sidebar).toggle()
  }
}
