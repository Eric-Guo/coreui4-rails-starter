require "application_system_test_case"

class AuthorizationTest < ApplicationSystemTestCase
  test "a non admin can manage their profile but cannot open admin pages" do
    login_as users(:user_fangzixue), scope: :user
    visit account_profile_path
    assert_current_path account_profile_path
    assert_selector "#user_preferred_language"
    assert_no_selector "#sidebar a[href='#{admin_users_path}']"

    [admin_users_path, admin_roles_path, admin_role_role_users_path(roles(:role_staff))].each do |path|
      visit path
      assert_current_path root_path
      assert_no_selector "a[href='#{new_admin_role_path}']"
    end
  end
end
