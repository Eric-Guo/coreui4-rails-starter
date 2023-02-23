module Admin
  class UsersController < ApplicationController
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      users = User.all
      respond_to do |format|
        format.html do
          add_to_breadcrumbs t(".title")
        end
        format.json do
          render json: UsersDatatable.new(params, users: users, view_context: view_context)
        end
      end
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
