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

    $(document).on('keydown', (event) => {
      switch(event.key) {
        case 'ArrowLeft':
          this.datatable.page('previous').draw('page');
          break;
        case 'ArrowRight':
          this.datatable.page('next').draw('page');
          break;
      }
    });    
  }

  reload() {
    this.datatable.ajax.reload(null, false);
  }

  disconnect() {
    $(document).off('keydown');    
    this.datatable.destroy();
  }
});
