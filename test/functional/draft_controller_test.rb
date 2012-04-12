require 'test_helper'

class DraftControllerTest < ActionController::TestCase
  test "should get league" do
    get :league
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

end
