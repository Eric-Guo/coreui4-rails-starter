class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_page_layout_data, if: -> { request.format.html? }

  protected

  def set_page_layout_data
    @_wrapper_class = %w[wrapper d-flex flex-column min-vh-100 bg-light]
    @_sidebar_name = "application"
  end

  def add_to_breadcrumbs(text, link = nil)
    @_breadcrumbs ||= []
    @_breadcrumbs.push(
      text: text,
      link: link
    )
  end
end
