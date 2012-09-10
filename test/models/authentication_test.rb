require "minitest_helper"

class AuthenticationTest < MiniTest::Rails::ActiveSupport::TestCase

  def test_object_is_invalid
    a = Authentication.new

    assert a.invalid?, "authentication is valid, wtf?"

    assert a.errors.include?(:provider)
    assert a.errors.include?(:uid)
    assert a.errors.includ?(:user_id)
    
  end
  
end
