module Admin
  class RolesController < BaseController
    include Pagy::Backend
    after_action :verify_policy_scoped, only: :index
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def index
      add_to_breadcrumbs t(".title")
      @pagy, @roles = pagy(policy_scope(Role).all)
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
