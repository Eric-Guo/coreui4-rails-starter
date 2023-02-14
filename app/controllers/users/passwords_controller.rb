class Users::PasswordsController < Devise::PasswordsController
  before_action :set_page_layout_data, only: %i[new edit]

  # GET /resource/password/new
  def new
    set_meta_tags title: t("devise.passwords.new.title")
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    set_meta_tags title: t("devise.passwords.edit.title")
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected

  def set_page_layout_data
    @_wrapper_class = %w[bg-light min-vh-100 d-flex flex-row align-items-center dark:bg-transparent]
    @_sidebar_name = nil
  end

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
