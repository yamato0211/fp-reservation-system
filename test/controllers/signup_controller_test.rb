require "test_helper"

class SignupControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get signup_show_url
    assert_response :success
  end
end
