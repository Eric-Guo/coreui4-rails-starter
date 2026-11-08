require "application_system_test_case"

class AdminRolesTest < ApplicationSystemTestCase
  setup do
    admin = users(:user_guochunzhong)
    admin.update!(preferred_language: "en")
    login_as admin, scope: :user
    visit admin_roles_path
  end

  test "creating and renaming a role updates the role list" do
    find("a[href='#{new_admin_role_path}']").click
    within "#coreuiModal.show" do
      fill_in "role_role_name", with: "Reviewers"
      find("input[type='submit']").click
    end
    assert_no_selector "#coreuiModal.show"
    assert_selector "tbody tr", text: "Reviewers"

    role = Role.find_by!(role_name: "Reviewers")
    find("a[href='#{edit_admin_role_path(role)}']").click
    within "#coreuiModal.show" do
      fill_in "role_role_name", with: "Editors"
      find("input[type='submit']").click
    end
    assert_no_selector "#coreuiModal.show"
    assert_selector "tbody tr", text: "Editors"
    assert_no_selector "tbody tr", text: "Reviewers"
    assert_equal "Editors", role.reload.role_name
  end

  test "remote user search adds a role member without replacing existing members and members can be removed" do
    role = roles(:role_staff)
    user = users(:user_fangzixue)
    admin = users(:user_guochunzhong)
    find("a[href='#{edit_admin_role_path(role)}']").click

    within "#coreuiModal.show" do
      find(".selectize-input input").set("fangzixue")
      find(".selectize-dropdown .option", text: user.email, exact_text: true).click
      find("input[type='submit']").click
    end
    assert_no_selector "#coreuiModal.show"
    visit admin_role_role_users_path(role)
    assert_selector "tbody tr", text: user.email
    assert_selector "tbody tr", text: admin.email

    within find("tbody tr", text: user.email) do
      click_button I18n.t("form.remove", locale: :en)
    end
    assert_no_selector "tbody tr", text: user.email
    assert_selector "tbody tr", text: admin.email
    assert_equal [admin.id], role.reload.users.ids
    assert_includes user.reload.roles, roles(:role_intern)
  end
end
