import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['link', 'content']
  static values = {
    contents: String
  }

  connect() {
    console.log('Hello copy');
  }
  copy(even) {
    navigator.clipboard.writeText(this.contentsValue);
    window.alert('Copied!');
  }
  toggle(event) {
    console.log('Hello');
    event.preventDefault();
    if (this.contentTarget.hidden) {
      this.contentTarget.hidden = false;
      this.linkTarget.innerHTML = this.linkTarget.innerHTML.replace(/^\[\+\]/m, '[-]');
    } else {
      this.contentTarget.hidden = true;
      this.linkTarget.innerHTML = this.linkTarget.innerHTML.replace(/^\[\-\]/m, '[+]');
    }
  }
}
