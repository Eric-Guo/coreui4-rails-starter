module Admin
  class HomeController < BaseController
    def index
    end

    protected

    def set_page_layout_data
      super
      @skip_title = true
    end
  end
end
