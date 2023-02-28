import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'

export default class extends Controller {
  click(e) {
    const target_url = e.target.getAttribute('href') || e.target.parentNode.getAttribute('href') || e.target.parentNode.parentNode.getAttribute('href');
    get(target_url).then((response) => {
      if (response.ok) {
        const result_text = response.text;
        result_text.then(result => {
          const htmlContent = document.getElementById('coreuiModal');
          htmlContent.innerHTML = result;
          const modal = new coreui.Modal('#coreuiModal');
          modal.show();
        });
      }
    });
    e.preventDefault();
  }
}
