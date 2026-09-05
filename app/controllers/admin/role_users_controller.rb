module Admin
  class RoleUsersController < BaseController
    after_action :verify_authorized, only: :destroy
    after_action :verify_policy_scoped, only: :index
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      role = Role.find params[:role_id]
      title = t(".title", role_name: role.role_name)
      add_to_breadcrumbs title
      set_meta_tags(title: title)
      @role_users = policy_scope(UserRole).where(role_id: role.id)
    end

    def destroy
      user_role = authorize UserRole.find(params[:id])
      user_role.destroy
      redirect_to admin_role_role_users_path(role_id: params[:role_id])
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
