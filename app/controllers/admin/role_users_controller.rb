module Admin
  class RoleUsersController < BaseController
    after_action :verify_policy_scoped, only: :index
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      add_to_breadcrumbs t(".title")
      @role_users = policy_scope(UserRole).all
    end

    private

    def set_breadcrumbs
      @_breadcrumbs = [
        {text: t("layouts.sidebars.admin.header"),
         link: root_path},
        {text: t("layouts.sidebars.admin.account"),
         link: nil},
        {text: t("layouts.sidebars.admin.roles"),
         link: admin_roles_path}
      ]
    end
  end
end
