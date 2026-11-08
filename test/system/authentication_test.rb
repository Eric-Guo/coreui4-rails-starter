require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_guochunzhong)
    @user.update!(password: "test-password", preferred_language: "en")
  end

  test "signing in returns to the requested page and signing out protects it again" do
    visit account_profile_path
    assert_current_path new_user_session_path

    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "test-password"
    find("input[type='submit']").click

    assert_current_path account_profile_path
    assert_selector "#user_preferred_language"

    find("header a[data-coreui-toggle='dropdown']").click
    within "header .dropdown-menu.show" do
      assert_text @user.email
      find("form[action='#{destroy_user_session_path}'] button").click
    end

    assert_current_path root_path
    visit account_profile_path
    assert_current_path new_user_session_path
  end

  test "an incorrect password does not grant access to an authenticated page" do
    visit new_user_session_path
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "incorrect-password"
    find("input[type='submit']").click

    assert_field "user_password", with: ""
    assert_selector "form#new_user input[type='submit']"
    assert_no_selector "#sidebar"
    visit account_profile_path
    assert_current_path new_user_session_path
  end

  test "a visitor can register and use the account menu" do
    visit new_user_registration_path
    fill_in "user_email", with: "new-user@example.com"
    fill_in "user_password", with: "test-password"
    fill_in "user_password_confirmation", with: "test-password"

    assert_difference("User.count", 1) do
      find("input[type='submit']").click
      assert_current_path root_path
    end

    find("header a[data-coreui-toggle='dropdown']").click
    within "header .dropdown-menu.show" do
      assert_text "new-user@example.com"
      find("a[href='#{account_profile_path}']").click
    end
    assert_current_path account_profile_path
  end
end
