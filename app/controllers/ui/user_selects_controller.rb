module UI
  class UserSelectsController < BaseController
    def show
      q = User.sanitize_sql_like(params[:q])
      @users = policy_scope(User).where("email LIKE ?", "%#{q}%").limit(7)
    end
  end
end
