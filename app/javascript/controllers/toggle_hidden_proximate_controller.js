import {Controller} from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['link', 'content']

  connect() {
    if ((this.data.get('anchor') != null) &&
      (window.location.hash == this.data.get('anchor'))) {
      this.linkTarget.click();
    }
  }

  toggle(event) {
    event.preventDefault();
    this.contentTargets.forEach((content) => {
      if (content.hidden) {
        content.hidden = false;
        this.linkTarget.innerHTML = this.linkTarget.innerHTML.replace(/^\[\+\]/m, '[-]');
      } else {
        content.hidden = true;
        this.linkTarget.innerHTML = this.linkTarget.innerHTML.replace(/^\[\-\]/m, '[+]');
      }
      if (this.data.get('anchor') != null) {
        history.pushState(null, null, this.data.get('anchor'));
        const element = content;
        const topPos = element.getBoundingClientRect().top + window.pageYOffset;

        window.scrollTo({
          top: topPos, // scroll so that the element is at the top of the view
          behavior: 'smooth', // smooth scroll
        });
        location.hash;
      }
    });
  }
}
