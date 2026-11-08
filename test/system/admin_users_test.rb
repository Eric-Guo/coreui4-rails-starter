require "application_system_test_case"

class AdminUsersTest < ApplicationSystemTestCase
  setup do
    admin = users(:user_guochunzhong)
    admin.update!(preferred_language: "en")
    login_as admin, scope: :user
    @user = users(:user_fangzixue)
    visit admin_users_path
    assert_selector "tbody tr", text: @user.email
  end

  test "searching the user table filters results and can be cleared" do
    search = find("input[type='search']")
    search.set(@user.email)
    within "tbody" do
      assert_text @user.email
      assert_no_text users(:user_guochunzhong).email
    end

    search.set("no-such-user@example.com")
    assert_selector "tbody td.dataTables_empty"
    assert_no_selector "tbody tr", text: @user.email

    search.set("")
    within "tbody" do
      assert_text @user.email
      assert_text users(:user_guochunzhong).email
    end
  end

  test "editing a user saves language and roles through the modal" do
    find("a[href='#{edit_admin_user_path(@user)}']").click

    within "#coreuiModal.show" do
      find("#user_preferred_language option[value='en']").select_option
      find(".selectize-input input").click
      find(".selectize-dropdown .option", text: "Staff", exact_text: true).click
      find("input[type='submit']").click
    end

    assert_no_selector "#coreuiModal.show"
    assert_selector "tbody tr", text: /#{Regexp.escape(@user.email)}.*en/m
    refresh
    assert_selector "tbody tr", text: /#{Regexp.escape(@user.email)}.*en/m
    find("a[href='#{edit_admin_user_path(@user)}']").click

    within "#coreuiModal.show" do
      assert_select "user_preferred_language", selected: "English"
      %w[Staff Intern Guest].each do |role_name|
        assert_selector ".selectize-input .item", text: role_name
      end
    end
    assert_equal roles(:role_staff, :role_intern, :role_guest).map(&:id).sort, @user.reload.roles.ids.sort
  end
end
