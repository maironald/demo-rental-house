/* eslint-disable new-cap */
/* eslint-disable no-underscore-dangle */
import { Controller } from '@hotwired/stimulus';
import flatpickr from 'flatpickr';

import 'flatpickr/dist/flatpickr.css';

const options = {
  altInput: true,
  altFormat: 'd/m/Y',
  dateFormat: 'Y-m-d',
};

const createFlatpickr = (element, opt) => {
  flatpickr(element, opt);
};

const destroyEl = (el) => {
  el._flatpickr.destroy();
};

export default class extends Controller {
  static targets = ['input'];

  inputTargetConnected(inputTarget) {
    createFlatpickr(inputTarget, options);
  }

  inputTargetDisconnected(el) {
    destroyEl(el);
  }
}
