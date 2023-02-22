module Accounts
  class ProfilesController < ApplicationController
    before_action :set_breadcrumbs, if: -> { request.format.html? }

    def show
      add_to_breadcrumbs t(".title")
      @user = current_user
    end

    def update
      if current_user.update_without_password(user_params)
        redirect_to account_profile_path, notice: t("accounts.profiles.show.updated")
      else
        render :show
      end
    end

    protected

    def set_page_layout_data
      super
      @_sidebar_name = "application"
    end

    private

    def user_params
      params.require(:user).permit(:preferred_language)
    end

    def set_breadcrumbs
      @_breadcrumbs = [
        {text: t("layouts.sidebars.application.header"),
         link: root_path},
        {text: t("layouts.sidebars.application.account"),
         link: nil}
      ]
    end
  end
end
