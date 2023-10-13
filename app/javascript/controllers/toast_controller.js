import { Controller } from "@hotwired/stimulus"
import { Toast } from 'bootstrap'

export default class extends Controller {
  connect() {
    this.toast = new Toast(
      document.getElementById('receiveToast')
    )
  }

  show({ detail: { chat, post }}) {
    // console.log(attr[detail])
    this.toast._element.querySelector('.me-auto').innerText = chat
    this.toast._element.querySelector('.toast-body').innerText = post
    this.toast.show()
  }
}
