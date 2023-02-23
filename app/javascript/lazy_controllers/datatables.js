import { Controller } from "@hotwired/stimulus"

Stimulus.register("datatables", class extends Controller {
  static targets = [ "datatable" ];
  static values = {
    dtUrl: String,
    columns: Array
  }

  connect() {
    if (typeof this.datatable == "undefined") {
      const columns = this.columnsValue.map(function(m) { return {"data": m} });
      this.datatable = $(this.datatableTarget).DataTable({
        "serverSide": true,
        "ajax": {
          "url": $(this.datatableTarget).data('source')
        },
        language: {
          "url": this.dtUrlValue
        },
        "pagingType": "full_numbers",
        "columns": columns
      });
    }
  }

  disconnect() {
    if (this.datatable.keys != undefined) {
      this.datatable.destroy();
    }
  }
})
