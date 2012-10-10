require "minitest_helper"

class Admin::EventsControllerTest < MiniTest::Rails::ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
