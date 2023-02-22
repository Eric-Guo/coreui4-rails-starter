module Admin
  class UsersController < ApplicationController
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      add_to_breadcrumbs t(".title")
      @users = User.all
    end

    private

    def set_breadcrumbs
      @_breadcrumbs = [
        {text: t("layouts.sidebars.admin.header"),
         link: root_path},
        {text: t("layouts.sidebars.admin.account"),
         link: nil}
      ]
    end
  end
end
