class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_brower, if: -> { request.format.html? }
  before_action :set_breadcrumbs, if: -> { request.format.html? }

  def index
    redirect_to admin_root_path if current_user&.admin?
  end

  protected

  def set_page_layout_data
    super
    @skip_title = true
  end

  private

  def set_breadcrumbs
    @_breadcrumbs = [
      {text: t("layouts.sidebars.application.header"),
       link: nil}
    ]
  end
end
