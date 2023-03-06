class HomeController < ApplicationController
  before_action :set_breadcrumbs, if: -> { request.format.html? }

  def index
    return redirect_to admin_root_path if current_user&.admin?
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
