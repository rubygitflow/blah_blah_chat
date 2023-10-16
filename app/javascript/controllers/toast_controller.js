import { Controller } from "@hotwired/stimulus"
import { Toast } from 'bootstrap'

export default class extends Controller {
  static targets = ['toast']

  initialize() {
    this.audio = new Audio(window.location.origin + '/513269__zhr__tl-light-on-e.mp3')
    this.toast = new Toast(
      document.getElementById('receiveToast')
    )
    this.toast_bak = toast.innerText.trim()
    this.toast_text = this.toast_bak
  }

  toastTargetConnected(e) {
    this.toast_bak  = e.innerText.trim()
    if (this.toast_bak === this.toast_text) {} else {
      this.toast_text = this.toast_bak
      if (this.toast_text === '') {} else {
        this.toast.show()
        this.audio.play()
      }
    }
  }
}
