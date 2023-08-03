import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  click() {
    const sidebarNode = document.getElementById('sidebar');
    const sidebar = coreui.Sidebar.getInstance(sidebarNode)
    console.log(sidebar._unfoldable);
  }
}
