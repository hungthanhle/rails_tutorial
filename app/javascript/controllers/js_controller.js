import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.write('<html><body><h2>DÙNG JS XEM SAO</h2></body></html>');
  }
}
