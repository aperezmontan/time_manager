import { Controller } from "@hotwired/stimulus"
import { Datepicker } from 'vanillajs-datepicker'

export default class extends Controller {

  static targets = [ "manuallyEditedDate" ]

  connect() {
    const element = this.manuallyEditedDateTarget

    new Datepicker(element, {autohide: true})
  }
}
