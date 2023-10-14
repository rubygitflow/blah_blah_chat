import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['post']
  initialize() {
    this.chat = document.getElementById('showChat')
    this.audio = new Audio(window.location.origin + '/513269__zhr__tl-light-on-e.mp3');
  }

  postTargetConnected(e) {
    let p = this.postTargets[0].innerText.split('>')[1]
    let c = this.chat.innerText
    this.dispatch('copy', { detail: { chat: c, post: p } })
    this.audio.play();
  }
}
