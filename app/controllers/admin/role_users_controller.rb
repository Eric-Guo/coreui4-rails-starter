module Admin
  class RoleUsersController < BaseController
    after_action :verify_policy_scoped, only: :index
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      role = Role.find params[:role_id]
      title = t(".title", role_name: role.role_name)
      add_to_breadcrumbs title
      set_meta_tags(title: title)
      @role_users = policy_scope(UserRole).where(role_id: role.id)
    end

    private

    def set_breadcrumbs
      @_breadcrumbs = [
        {text: t("layouts.sidebars.admin.header"),
         link: root_path},
        {text: t("layouts.sidebars.admin.account"),
         link: nil},
        {text: t("user.roles"),
         link: admin_roles_path}
      ]
    end
  end
end
