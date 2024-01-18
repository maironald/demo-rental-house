import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['rightContainer', 'leftDiv', 'siteTitle'];

  connect() {
    this.check = true;
  }
  navbarCloseOpen(event) {
    event.preventDefault();
    if (window.innerWidth > 991) {
      if (!this.check) {
        this.tagInBody().classList.remove('nav-sm');
        this.rightContainerTarget.style.marginLeft = '230px';
        this.check = true;
        this.siteTitleTarget.innerText = 'QUẢN LÝ NHÀ TRỌ';
      } else {
        this.leftDivTarget.style.display = 'block';
        this.tightContainerTarget.style.marginLeft = '80px';
        this.tagInBody().classList.add('nav-sm');
        this.siteTitleTarget.innerText = 'QLNT';
        this.check = false;
      }
    } else {
      if (!this.check) {
        this.leftDivTarget.style.display = 'none';
        this.rightContainerTarget.style.marginLeft = '0';
        this.check = true;
      } else {
        this.leftDivTarget.style.display = 'block';
        this.rightContainerTarget.style.marginLeft = '80px';
        this.tagInBody().classList.add('nav-sm');
        this.siteTitleTarget.innerText = 'QLNT';
        this.check = false;
      }
    }
  }
  tagInBody() {
    return this.element.querySelector('body');
  }
}
