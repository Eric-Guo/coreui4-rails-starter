class HomeController < ApplicationController
  before_action :set_breadcrumbs, if: -> { request.format.html? }

  def index
  end

  protected

  def set_page_layout_data
    super
    @skip_title = true
  end

  private

  def set_breadcrumbs
    @_breadcrumbs = [
      {text: t("layouts.sidebars.admin.header"),
       link: nil}
    ]
  end
end
