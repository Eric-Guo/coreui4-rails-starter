class Users::SessionsController < Devise::SessionsController
  before_action :set_page_layout_data, only: :new
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    set_meta_tags title: t("devise.sessions.new.title")
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def set_page_layout_data
    @_wrapper_class = %w[bg-light min-vh-100 d-flex flex-row align-items-center dark:bg-transparent]
    @_sidebar_name = nil
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
