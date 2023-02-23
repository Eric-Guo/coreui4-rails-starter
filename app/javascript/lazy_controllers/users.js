import { Controller } from "@hotwired/stimulus"

Stimulus.register("datatables", class extends Controller {
  static targets = [ "datatable" ];

  connect() {
    if (typeof this.datatable == "undefined") {
      this.datatable = $(this.datatableTarget).DataTable({
        "processing": true,
        "serverSide": true,
        "ajax": {
          "url": $(this.datatableTarget).data('source')
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
