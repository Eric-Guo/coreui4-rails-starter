# frozen_string_literal: true

module SidebarHelper
  def render_sidebar
    return if @_sidebar_name.nil?
    render "layouts/sidebars/#{@_sidebar_name}"
  end
end
