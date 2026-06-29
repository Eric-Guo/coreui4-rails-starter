require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  def test_scope
    user = users(:user_fangzixue)

    assert_equal [user], UserPolicy::Scope.new(user, User).resolve.to_a
  end

  def test_sign_in_as
    target_user = users(:user_fangzixue)

    assert UserPolicy.new(users(:user_guochunzhong), target_user).sign_in_as?
    assert_not UserPolicy.new(target_user, users(:user_guochunzhong)).sign_in_as?
  end
end
