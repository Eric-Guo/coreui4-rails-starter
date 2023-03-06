require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get root after sign in" do
    sign_in users(:user_fangzixue)
    get root_url
    assert_response :success
  end

  test "should redirect to admin home page if user admin" do
    sign_in users(:user_guochunzhong)
    get root_url
    assert_response :redirect
    assert_redirected_to admin_root_path
  end

  test "should redirect to sign in page if not sign in" do
    get root_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
end
