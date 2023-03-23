module UI
  class NavGroupItemsController < BaseController
    skip_before_action :authenticate_user!

    def account
    end
  end
end
