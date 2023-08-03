module Accounts
  class ProfilesController < ApplicationController
    before_action :set_user, only: %i[show update]
    before_action :set_breadcrumbs, if: -> { request.format.html? }
    after_action :verify_authorized

    def show
      add_to_breadcrumbs t(".title")
    end

    def update
      respond_to do |format|
        format.html do
          if @user.update_without_password(user_params)
            redirect_to account_profile_path, notice: t("accounts.profiles.show.updated")
          else
            render :show
          end
        end
        format.json do
          @user.update_without_password(sidebar_narrow: params[:sidebar_unfoldable])
        end
      end
    end

    protected

    def set_page_layout_data
      super
      @_sidebar_name = "application"
    end

    private

    def set_user
      @user = authorize(current_user, :edit?)
    end

    def user_params
      params.require(:user).permit(:preferred_language, :preferred_page_length, :sidebar_narrow)
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
