module Admin
  class BaseController < ::ApplicationController
    before_action :require_admin!

    protected

    def require_admin!
      unless user_signed_in? && current_user.admin?
        redirect_back fallback_location: root_url
      end
    end
  end
end
