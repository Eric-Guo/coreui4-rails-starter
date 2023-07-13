module Admin
  class HomeController < BaseController
    before_action :check_brower, if: -> { request.format.html? }

    def index
    end

    protected

    def set_page_layout_data
      super
      @skip_title = true
    end
  end
end
