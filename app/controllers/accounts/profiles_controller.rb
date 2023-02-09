# frozen_string_literal: true

module Accounts
  class ProfilesController < ApplicationController
    def show
      @user = current_user
    end

    def update
      if current_user.update_without_password(user_params)
        redirect_to account_profile_path, notice: t("accounts.profiles.show.updated")
      else
        render :show
      end
    end

    private

    def user_params
      params.require(:user).permit(:email)
    end
  end
end
