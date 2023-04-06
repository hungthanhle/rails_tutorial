import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    $(document).ready(function(){
      $("button").click(function(){
        // $("p").hide();

        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {
          console.log(this);
          document.getElementById('A1').innerHTML = this.userId;
          document.getElementById('A2').innerHTML = this.id;
          document.getElementById('A3').innerHTML = this.title;
          document.getElementById('A4').innerHTML = this.completed;
          document.getElementById('A5').innerHTML = this.status;
          document.getElementById('A6').innerHTML = this.response;
        }
        xhttp.open("GET", 'https://jsonplaceholder.typicode.com/todos/1');
        xhttp.send();
      });
    });

    console.log("Hello")

    function loadDoc() {
      const xhttp = new XMLHttpRequest();
      xhttp.onload = function() {
        console.log(this);
        document.getElementById('A1').innerHTML = this.userId;
        document.getElementById('A2').innerHTML = this.id;
        document.getElementById('A3').innerHTML = this.title;
        document.getElementById('A4').innerHTML = this.completed;
        document.getElementById('A5').innerHTML = this.status;
        document.getElementById('A6').innerHTML = this.response;
      }
      xhttp.open("GET", 'https://jsonplaceholder.typicode.com/todos/1');
      xhttp.send();
    }
  }
}
