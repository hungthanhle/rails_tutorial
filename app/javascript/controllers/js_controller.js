import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.write('<html><body><h2>This is a heading</h2><p>This is a paragraph.</p><p>This is another paragraph.</p><button>Click me to hide paragraphs</button></html>');
    $(document).ready(function(){
      $("button").click(function(){
        $("p").hide();
      });
    });
  }
}
