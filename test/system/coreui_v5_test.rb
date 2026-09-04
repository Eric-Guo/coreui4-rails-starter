require "application_system_test_case"
require "warden/test/helpers"

class CoreuiV5Test < ApplicationSystemTestCase
  include Warden::Test::Helpers

  teardown do
    Warden.test_reset!
  end

  test "theme and sidebar controls work" do
    visit root_path

    assert_selector "body[data-controller~='coreui'][data-controller~='theme']", visible: :all
    assert_selector "#sidebar.sidebar"

    find("button[aria-label='Select color theme']").click
    find("button[data-coreui-theme-value='dark']").click
    assert_selector "html[data-coreui-theme='dark']", visible: :all

    refresh
    assert_selector "html[data-coreui-theme='dark']", visible: :all

    find("button[aria-label='Toggle narrow sidebar']").click
    assert_selector "#sidebar.sidebar-narrow-unfoldable"
  end

  test "page-specific packs initialize after the application pack" do
    login_as users(:user_guochunzhong), scope: :user

    visit admin_root_path
    assert_selector "[data-controller='dashboard'][data-chart-initialized='true'] canvas"

    visit admin_users_path
    assert_selector "[data-controller='datatables'][data-datatables-initialized='true'] tbody tr", minimum: 1

    find("a[data-controller='modal'][href$='/edit']", match: :first).click
    assert_selector "#coreuiModal.show [data-controller='selectizes'] .selectize-control"

    sleep 0.5
    find("#coreuiModal .btn-close").click
    assert_no_selector "#coreuiModal.show"
    assert_selector "[data-controller='datatables'] tbody tr", minimum: 1
  end
end
