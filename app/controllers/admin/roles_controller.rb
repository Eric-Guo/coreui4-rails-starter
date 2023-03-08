module Admin
  class RolesController < BaseController
    include Pagy::Backend
    after_action :verify_policy_scoped, only: :index
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      add_to_breadcrumbs t(".title")
      @pagy, @roles = pagy(policy_scope(Role).all)
    end

    def new
      @role = Role.new
      render layout: false
    end

    def create
      Role.create(role_params)
    end

    private

    def role_params
      params.require(:role).permit(:role_name)
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
