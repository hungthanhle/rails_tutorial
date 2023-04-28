require "test_helper"

class BroadcastTest < ActionCable::Channel::TestCase
  
  # `assert_broadcast_on` asserts exact message sent on a channel stream.
  test "asserts exact message" do
    created_at = Time.now
    ActionCable.server.broadcast("notification_channel_1", {
      created_at: created_at,
      content: "Hùng Lê đã react tại Hello World",
      reactNum: 1,
      reactPostID: 1
    })
    assert_broadcast_on('notification_channel_1', {
      created_at: created_at,
      content: "Hùng Lê đã react tại Hello World",
      reactNum: 1,
      reactPostID: 1
    })
  end

  # `assert_broadcasts` asserts the number of messages sent to stream
  test "asserts number of messages " do
    created_at = Time.now
    assert_broadcasts 'notification_channel_1', 0
    ActionCable.server.broadcast("notification_channel_1", {
      created_at: created_at,
      content: "Hùng Lê đã react tại Hello World",
      reactNum: 1,
      reactPostID: 1
    })
    assert_broadcasts 'notification_channel_1', 1
    ActionCable.server.broadcast("notification_channel_1", {
      created_at: created_at,
      content: "Hùng Lê đã react tại Hello World",
      reactNum: 1,
      reactPostID: 1
    })
    assert_broadcasts 'notification_channel_1', 2
  end
end
