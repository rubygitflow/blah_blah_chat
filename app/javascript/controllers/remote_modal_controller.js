import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  connect() {
    const myInput = document.getElementById('chat_topic')

    this.modal = new Modal(this.element)
    this.element.addEventListener('shown.bs.modal', () => { myInput.focus() })
    this.modal.show()
  }

  hideBeforeRender(event) {
    console.log("!!>")
    if (this.isOpen()) {
      console.log('hideBeforeRender.isOpen')
      event.preventDefault()
      this.element.addEventListener('hidden.bs.modal', event.detail.resume)
      this.modal.hide()
      // eliminate the consequences of double clicks after closeWithKeyboard
      let elements = document.getElementsByClassName('modal-backdrop');
      while(elements.length > 0){
          elements[0].parentNode.removeChild(elements[0]);
      }
    }
  }

  isOpen() {
    return this.element.classList.contains("show")
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideBeforeRender(e)
    }
  }

  // // hide modal on successful form submission
  // // action: "turbo:submit-end->turbo-modal#submitEnd"
  // submitEnd(e) {
  //   console.log(e.detail)
  //   if (e.detail.success) {
  //     this.hideBeforeRender(e)
  //   }
  // }

}
