require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get root after sign in" do
    sign_in users(:guochunzhong)
    get root_url
    assert_response :success
  end

  test "should redirect to sign in page if not sign in" do
    get root_url
    assert_response :redirect
  end
end
