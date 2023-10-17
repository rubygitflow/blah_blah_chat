import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log('autohide connect')
    setTimeout(() => { this.dismiss() }, 5000)
  }

  dismiss() {
    console.log('autohide auto')
    this.element.remove()
  }
}
