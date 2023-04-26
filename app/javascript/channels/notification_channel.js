import consumer from "channels/consumer"

document.addEventListener('turbo:load',()=>{
  consumer.subscriptions.create({
    channel: "NotificationChannel"
  }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('connected!')
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log(data)
      
      // Push notification
      if(Notification.permission == 'granted'){
        let title = "Push Notification"
        let options = {body: data}
        new Notification(title, options)
      }
    }
  });
})
