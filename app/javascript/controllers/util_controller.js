import { Controller } from "@hotwired/stimulus"
// import * as popper from "@popperjs/core"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = ['link', 'content']

  connect() {
    console.log('Hello util');
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  }
}
