require "test_helper"
 
class NotificationChannelTest < ActionCable::Channel::TestCase
  test "subscribes and stream for a match" do
    # Simulates the subscription to the channel
    subscribe notication_user_id: "1"
    
    # The channel object is available as `subscription` identifier.

    # We can check that subscription was successfully created. 
    assert subscription.confirmed?

    # We can check that channel subscribed the connection to correct stream
    assert_has_stream "notification_channel_1"
  end
end
