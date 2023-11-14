require "test_helper"

class FinancialPlannersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get financial_planners_index_url
    assert_response :success
  end
end
