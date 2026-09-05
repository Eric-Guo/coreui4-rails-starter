require "test_helper"

module Admin
  class RoleUsersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    test "admin can remove user from role" do
      sign_in users(:user_guochunzhong)
      user_role = user_roles(:ur_one)

      assert_difference("UserRole.count", -1) do
        delete admin_role_role_user_path(role_id: user_role.role_id, id: user_role.id)
      end
      assert_redirected_to admin_role_role_users_path(role_id: user_role.role_id)
      assert_not UserRole.exists?(user_role.id)
    end

    test "non admin can not remove user from role" do
      sign_in users(:user_fangzixue)
      user_role = user_roles(:ur_one)

      assert_no_difference("UserRole.count") do
        delete admin_role_role_user_path(role_id: user_role.role_id, id: user_role.id)
      end
    end
  end
end
