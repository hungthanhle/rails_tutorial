require "test_helper"

class AjaxControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get ajax_create_url
    assert_response :success
  end
end
