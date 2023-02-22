class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_new_page_layout_data, only: %i[new]
  before_action :set_edit_page_layout_data, only: %i[edit]
  before_action :set_breadcrumbs, only: %i[edit]

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    set_meta_tags title: t("devise.registrations.new.title")
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    add_to_breadcrumbs t(".title")
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def set_new_page_layout_data
    @_wrapper_class = %w[bg-light min-vh-100 d-flex flex-row align-items-center dark:bg-transparent]
    @_sidebar_name = nil
  end

  def set_edit_page_layout_data
    @_wrapper_class = %w[wrapper d-flex flex-column min-vh-100 bg-light]
    @_sidebar_name = "application"
  end

  def set_breadcrumbs
    @_breadcrumbs = [
      {text: t("layouts.sidebars.application.header"),
       link: root_path},
      {text: t("layouts.sidebars.application.account"),
       link: nil}
    ]
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
