module Admin
  class UsersController < ApplicationController
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
    before_action :set_user, only: %i[show sign_in_as]
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      users = policy_scope(User).all
      respond_to do |format|
        format.html do
          add_to_breadcrumbs t(".title")
        end
        format.json do
          render json: UsersDatatable.new(params, users: users, current_user: current_user, view_context: view_context)
        end
      end
    end

    def show
      render layout: false
    end

    def sign_in_as
      return redirect_to root_path, notice: t(".not_allow") unless current_user.admin?

      sign_in @user
      redirect_to root_path
    end

    private

    def set_user
      @user = authorize User.find(params[:id])
    end

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
