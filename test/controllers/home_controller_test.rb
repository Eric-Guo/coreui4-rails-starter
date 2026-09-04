require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get root after sign in" do
    sign_in users(:user_fangzixue)
    get root_url
    assert_response :success
    assert_select "body[data-controller~=?]", "coreui"
    assert_select "body[data-controller~=?]", "theme"
    assert_select ".sidebar-header .sidebar-brand"
    assert_select "[data-coreui-theme-value]", count: 3
    assert_select "script[src*='application']"
  end

  test "should redirect to admin home page if user admin" do
    sign_in users(:user_guochunzhong)
    get root_url
    assert_response :redirect
    assert_redirected_to admin_root_path
  end

  test "should get root if not sign in" do
    get root_url
    assert_response :success
    assert_select ".sidebar[data-controller='sidebar']"
    assert_select ".sidebar-nav[data-coreui='navigation']"
  end
end
