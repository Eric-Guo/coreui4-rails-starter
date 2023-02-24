class UsersDatatable < ApplicationDatatable
  def initialize(params, opts = {})
    @users = opts[:users]
    super
  end

  def view_columns
    @view_columns ||= {
      email: {source: "User.email", cond: :like},
      preferred_language: {source: "User.preferred_language", searchable: false, orderable: false},
      status: {source: nil, searchable: false, orderable: false},
      actions: {source: nil, searchable: false, orderable: false}
    }
  end

  def data
    records.map do |r|
      {
        email: r.email,
        preferred_language: r.preferred_language,
        status: r.admin? ? content_tag("span", I18n.t("user.admin"), class: "badge bg-danger") : "",
        actions: "",
        DT_RowId: r.id # This will automagically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    @users
  end
end
