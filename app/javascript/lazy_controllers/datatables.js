import { Controller } from "@hotwired/stimulus"

Stimulus.register("datatables", class extends Controller {
  static targets = [ "datatable" ];
  static values = {
    pageLength: Number,
    source: String,
    dtUrl: String,
    columns: Array
  }

  connect() {
    const columns = this.columnsValue.map(function(m) { return {"data": m} });
    this.datatable = $(this.datatableTarget).DataTable({
      "serverSide": true,
      "ajax": {
        "url": this.sourceValue
      },
      language: {
        "url": this.dtUrlValue
      },
      "pageLength": this.pageLengthValue,
      "pagingType": "full_numbers",
      "columns": columns
    });
  }

  reload() {
    this.datatable.ajax.reload(null, false);
  }

  disconnect() {
    this.datatable.destroy();
  }
});
