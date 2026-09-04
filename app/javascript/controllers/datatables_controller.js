import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["datatable"]
  static values = {
    pageLength: Number,
    source: String,
    dtUrl: String,
    columns: Array
  }

  async connect() {
    this.connected = true
    const { default: $ } = await import("jquery")
    window.$ = $
    window.jQuery = $
    await import("datatables.net-bs5")
    if (!this.connected) return

    const columns = this.columnsValue.map((column) => ({ data: column }))
    this.datatable = $(this.datatableTarget).DataTable({
      serverSide: true,
      ajax: {
        url: this.sourceValue
      },
      language: {
        url: this.dtUrlValue
      },
      pageLength: this.pageLengthValue,
      pagingType: "full_numbers",
      columns
    })

    this.keydownHandler = (event) => {
      if (event.key === "ArrowLeft") this.datatable.page("previous").draw("page")
      if (event.key === "ArrowRight") this.datatable.page("next").draw("page")
    }
    document.addEventListener("keydown", this.keydownHandler)
    this.element.dataset.datatablesInitialized = "true"
  }

  reload() {
    this.datatable?.ajax.reload(null, false)
  }

  disconnect() {
    this.connected = false
    if (this.keydownHandler) document.removeEventListener("keydown", this.keydownHandler)
    this.datatable?.destroy()
  }
}
