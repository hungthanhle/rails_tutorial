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
        `<a href=${data.href}>
        <div class="notification-not-checked-item notification-item">
          <h4 class="item-title">Lúc ${formatTime(data.created_at)}</h4>
          <p class="item-info">${data.content}</p>
        </div>
        </a>`);

      if($(`#notification-number`).length > 0){
        $(`#notification-number`).replaceWith(`<div id="notification-number">${data.notiNotReadNum}</div>`)
      }else {
        $(`#dLabel`).prepend(`<div id="notification-number">${data.notiNotReadNum}</div>`)
      }
      
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
  let year = formatTime.getUTCFullYear();
  let month = ("0"+ (formatTime.getUTCMonth() + 1)).slice(-2);
  let date = ("0"+ formatTime.getUTCDate()).slice(-2);
  let hours = ("0"+ formatTime.getUTCHours()).slice(-2);
  let minutes = ("0"+ formatTime.getUTCMinutes()).slice(-2);

  return `${year}-${month}-${date} ${hours}:${minutes} UTC`;
}
