module UI
  class AvatarAreasController < BaseController
    skip_before_action :authenticate_user!

    def show
    end
  end
end
