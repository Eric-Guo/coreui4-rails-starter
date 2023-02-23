jQuery(document).ready(function() {
  $('#users-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#users-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "email"},
      {"data": "preferred_language"},
      {"data": "status"},
      {"data": "actions"}
    ]
  });
});
