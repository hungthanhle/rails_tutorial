import consumer from "channels/consumer"

document.addEventListener('turbo:load',()=>{
  consumer.subscriptions.create({
    channel: "NotificationChannel"
  }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      // NOTIFICATION
      $('.notifications-wrapper').prepend(
        `<div class="notification-item">
          <h4 class="item-title">Lúc ${formatTime(data.created_at)}</h4>
          <p class="item-info">${data.content}</p>
        </div>`);
      
      // REACT
      if(data.reactNum){
        $(`#micropost_${data.reactPostID}_form`).children('.reactNum').replaceWith(`<h3>React (${data.reactNum})</h3>`)
      }

      // Push notification
      if(Notification.permission == 'granted'){
        let title = "Push Notification"
        let options = {body: data.content}
        new Notification(title, options)
      }
    }
  });
})

function formatTime(time) {
  let formatTime = new Date(time)
  let month = formatTime.getUTCMonth();
  let year = formatTime.getUTCFullYear();
  let date = formatTime.getUTCDate();
  let hours = formatTime.getUTCHours();
  hours = ("0" + hours).slice(-2);
  let minutes = formatTime.getUTCMinutes();

  return `${year}-${month}-${date} ${hours}:${minutes} UTC`;
}
