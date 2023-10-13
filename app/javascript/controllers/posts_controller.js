import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['post', 'link']
  initialize() {
    this.chat = document.getElementById('showChat')
  }

  postTargetConnected(e) {
    let p = this.postTargets[0].innerText.split('>')[1]
    let c = this.chat.innerText
    this.dispatch('copy', { detail: { chat: c, post: p } })
  }
}
