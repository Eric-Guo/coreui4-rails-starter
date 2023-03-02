import { Controller } from "@hotwired/stimulus"

Stimulus.register("datatables", class extends Controller {
  static targets = [ "datatable" ];
  static values = {
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
      "pagingType": "full_numbers",
      "columns": columns
    });
  }

  reload() {
    this.datatable.ajax.reload();
  }

  disconnect() {
    this.datatable.destroy();
  }
});
