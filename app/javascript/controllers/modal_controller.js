import { Controller } from "@hotwired/stimulus"
import { Modal } from "@coreui/coreui-pro"
import { get } from "@rails/request.js"

export default class extends Controller {
  static values = {
    pageReload: Boolean
  }

  click(e) {
    const targetUrl = e.currentTarget.getAttribute("href")
    get(targetUrl).then((response) => {
      if (response.ok) {
        response.text.then((result) => {
          const htmlContent = document.getElementById("coreuiModal")
          htmlContent.innerHTML = result
          const modal = Modal.getOrCreateInstance(htmlContent)
          modal.show()
          htmlContent.addEventListener("hidden.coreui.modal", () => {
            if (this.pageReloadValue) {
              location.reload()
            } else {
              this.dispatch("reloadDT", { detail: {}, target: document })
            }
          }, { once: true })
        })
      }
    })
    e.preventDefault()
  }
}
