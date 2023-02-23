import { Controller } from "@hotwired/stimulus"

Stimulus.register("datatables", class extends Controller {
  static targets = [ "datatable" ];
  static values = {
    dtUrl: String
  }

  connect() {
    if (typeof this.datatable == "undefined") {
      this.datatable = $(this.datatableTarget).DataTable({
        "serverSide": true,
        "ajax": {
          "url": $(this.datatableTarget).data('source')
        },
        language: {
          "url": this.dtUrlValue
        },
        "pagingType": "full_numbers",
        "columns": [
          {"data": "email"},
          {"data": "preferred_language"},
          {"data": "status"},
          {"data": "actions"}
        ]
      });
    }
  }

  disconnect() {
    if (this.datatable.keys != undefined) {
      this.datatable.destroy();
    }
  }
})
