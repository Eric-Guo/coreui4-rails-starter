require "application_system_test_case"

class ProfileTest < ApplicationSystemTestCase
  test "saved preferences persist and apply to the sidebar and user table" do
    user = users(:user_guochunzhong)
    user.update!(preferred_language: "en")
    login_as user, scope: :user
    visit account_profile_path

    find("#user_preferred_language option[value='zh-CN']").select_option
    select "25", from: "user_preferred_page_length"
    check "user_sidebar_narrow"
    find("input[type='submit']").click

    assert_current_path account_profile_path
    assert_selector "html[lang='zh-CN']", visible: :all
    assert_selector "#sidebar.sidebar-narrow-unfoldable"

    refresh
    assert_select "user_preferred_page_length", selected: "25"
    assert_select "user_preferred_language", selected: "简体中文"
    assert_checked_field "user_sidebar_narrow"

    visit admin_users_path
    assert_selector "html[lang='zh-CN']", visible: :all
    assert_selector "#sidebar.sidebar-narrow-unfoldable"
    assert_selector "select[name$='_length'] option:checked", text: "25", visible: :all
    assert_selector "tbody tr", text: users(:user_fangzixue).email
  end
end
