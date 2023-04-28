require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  # test "connect" do
  #   = a || b
  #   cookies.encrypted["user_id"] = @user.id
  #   connect
  #   assert_equal connection.current_user.id, @user.id
  # end

  test "connect" do
    connect session: {user_id: @user.id}
    assert_equal connection.current_user.id, @user.id
  end

  test "connection rejected without log in" do
    assert_reject_connection { connect }
  end
end
