class UsersDatatable < ApplicationDatatable
  def_delegator :@view, :button_to
  def_delegator :@view, :sign_in_as_admin_user_path

  def initialize(params, opts = {})
    @users = opts[:users]
    @current_user = opts[:current_user]
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
        status: render(partial: "datatable/user_status", locals: {user: r}, formats: :html),
        actions: render(partial: "datatable/user_action", locals: {user: r}, formats: :html),
        DT_RowId: r.id # This will automagically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    @users
  end
end
