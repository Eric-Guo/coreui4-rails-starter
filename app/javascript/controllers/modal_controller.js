import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  click(e) {
    const modal = new coreui.Modal('#coreuiModal');
    modal.show();
    e.preventDefault();
  }
}
