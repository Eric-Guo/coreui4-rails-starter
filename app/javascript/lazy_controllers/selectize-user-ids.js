import { Controller } from "@hotwired/stimulus"

let roleUserIDsSelect;

Stimulus.register("selectize-user-ids", class extends Controller {
  connect() {
    roleUserIDsSelect = $('#user-ids-select').selectize({
      plugins: ["remove_button"],
      respect_word_boundaries: false,
      valueField: "id",
      labelField: "name",
      searchField: "name",
      create: false,
      load: function (query, callback) {
        if (!query.length) return callback();
        $.ajax({
          url: "/ui/user_select.json?q=" + encodeURIComponent(query),
          type: "GET",
          error: function () {
            callback();
          },
          success: function (res) {
            callback(res.users);
          },
        });
      },
    });
  }

  disconnect() {
    const need_destroy = roleUserIDsSelect[0].selectize;
    if(need_destroy) {
      need_destroy.destroy();
    }
  }
});
