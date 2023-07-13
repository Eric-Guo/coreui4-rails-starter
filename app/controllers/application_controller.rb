class ApplicationController < ActionController::Base
  include Pundit::Authorization

  include SetLocale

  before_action :authenticate_user!
  before_action :set_page_layout_data, if: -> { request.get? && request.format.html? }
  before_action :prepare_meta_tags, if: -> { request.get? && request.format.html? }

  protected

  def set_page_layout_data
    @_wrapper_class = %w[wrapper d-flex flex-column min-vh-100 bg-light]
    @_container_class = "container-lg"
    @_sidebar_name = if current_user&.admin?
      "admin"
    else
      "application"
    end
  end

  def add_to_breadcrumbs(text, link = nil)
    @_breadcrumbs ||= []
    @_breadcrumbs.push(
      text: text,
      link: link
    )
  end

  private

  def prepare_meta_tags
    set_meta_tags title: t(".title")
  end

  def modern_browser?
    [
      browser.bot?, # support rails test
      browser.chrome?(">= 86"),
      browser.safari?(">= 12"),
      browser.firefox?(">= 86"),
      browser.edge?(">= 86"),
      browser.opera?(">= 75")
    ].any?
  end

  def check_brower
    unless modern_browser?
      redirect_to "/nosupport-browser.html"
    end
  end
end
