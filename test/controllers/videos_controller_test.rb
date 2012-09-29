require "minitest_helper"

class VideosControllerTest < MiniTest::Rails::ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    video = Video.first

    get :show
    
    assert_response :success
  end

end
