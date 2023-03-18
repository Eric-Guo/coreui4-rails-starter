module Admin
  class UsersController < BaseController
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
    before_action :set_user, only: %i[edit update impersonation sign_in_as]
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

    def new
      @user = authorize User.new
      render layout: false
    end

    def create
      authorize User.create(user_params)
    end

    def edit
      render layout: false
    end

    def update
      @user.update_without_password(user_params)
      head :no_content
    end

    def impersonation
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

    def user_params
      params.require(:user).permit(:preferred_language, role_ids: [])
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
