import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = [ "htc", "rd" ]
  static values = { url: String, loaded: Boolean }

  click() {
    if (this.loadedValue == false) {
      get(this.urlValue).then((response) => {
        if (response.ok) {
          const result_text = response.text;
          result_text.then(result => {
            const htmlContent = this.htcTarget;
            htmlContent.innerHTML = result;
          });
          if (this.hasRdTarget) {
            const redDot = this.rdTarget;
            redDot.parentNode.removeChild(redDot);
          }
        }
      });
      this.loadedValue = true;
    }
  }
}
