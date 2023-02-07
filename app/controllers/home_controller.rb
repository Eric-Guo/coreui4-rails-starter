class HomeController < ApplicationController
  def root
  end

  protected

  def set_page_layout_data
    @_wrapper_class = %w[bg-light min-vh-100 d-flex flex-row align-items-center dark:bg-transparent]
  end
end
