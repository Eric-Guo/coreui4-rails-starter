import { Controller } from "@hotwired/stimulus"
import { Modal } from "@coreui/coreui-pro"
import { FetchRequest, get } from "@rails/request.js"

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
          htmlContent.addEventListener("hide.coreui.modal", () => {
            if (this.pageReloadValue) {
              location.reload()
            }
          }, { once: true })
          htmlContent.addEventListener("hidden.coreui.modal", () => {
            this.dispatch("reloadDT", { detail: {}, target: document })
          }, { once: true })
        })
      }
    })
    e.preventDefault()
  }

  async submit(event) {
    event.preventDefault()
    if (this.submitting) return

    this.submitting = true
    const submitter = event.submitter
    if (submitter) submitter.disabled = true

    try {
      const request = new FetchRequest(this.element.method, this.element.action, {
        body: new FormData(this.element)
      })
      const response = await request.perform()
      if (response.ok) Modal.getInstance(this.element.closest(".modal"))?.hide()
    } finally {
      this.submitting = false
      if (submitter) submitter.disabled = false
    }
  }
}
