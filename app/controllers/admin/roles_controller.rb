module Admin
  class RolesController < BaseController
    include Pagy::Backend
    after_action :verify_authorized, except: %i[index expender]
    after_action :verify_policy_scoped, only: %i[index expender]
    before_action :set_role, only: %i[edit update]
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      add_to_breadcrumbs t("user.roles")
      @pagy, @roles = pagy(policy_scope(Role).all, items: current_user.preferred_page_length)
    end

    def new
      @role = authorize Role.new
      render layout: false
    end

    def create
      authorize Role.create(role_params)
    end

    def edit
      render layout: false
    end

    def update
      @role.update(role_params)
    end

    def expender
      @roles = policy_scope(Role).all
      render layout: false
    end

    private

    def set_role
      @role = authorize Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:role_name, user_ids: [])
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
