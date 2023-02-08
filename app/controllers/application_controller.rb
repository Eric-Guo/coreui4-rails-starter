class ApplicationController < ActionController::Base
  include SidebarHelper
  before_action :authenticate_user!
  before_action :set_page_layout_data, if: -> { request.format.html? }

  protected

  def set_page_layout_data
    @_wrapper_class = %w[wrapper d-flex flex-column min-vh-100 bg-light]
    @_sidebar_name = "application"
  end
end
