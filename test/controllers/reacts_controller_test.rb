require "test_helper"

class ReactsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reacts_create_url
    assert_response :success
  end
end
