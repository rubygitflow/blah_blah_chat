import { Controller } from "@hotwired/stimulus"
import { Toast } from 'bootstrap'

export default class extends Controller {
  static targets = ['toast']
  static values = {
    id: String
  }

  initialize() {
    this.audio = new Audio(
      window.location.origin + '/513269__zhr__tl-light-on-e.mp3'
    )
    this.toast = new Toast(
      document.getElementById('receiveToast')
    )
  }

  idValueChanged(value, previousValue) {
    if (!(value === '')) {
      this.toast.show()
      this.audio.play()
    }
  }
}
