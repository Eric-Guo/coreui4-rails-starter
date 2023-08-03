import { Controller } from "@hotwired/stimulus"
import { put } from '@rails/request.js'

export default class extends Controller {
  click() {
    const sidebarNode = document.getElementById('sidebar');
    const sidebar = coreui.Sidebar.getInstance(sidebarNode);
    put("/account/profile.json", {body: {sidebar_unfoldable: sidebar._unfoldable}});
  }
}
