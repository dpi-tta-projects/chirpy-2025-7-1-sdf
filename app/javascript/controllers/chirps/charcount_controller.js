import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chirps--charcount"
export default class extends Controller {
  static targets = ["input", "bar", "label"]
  static values = { max: Number }

  connect() {
    this.update()
  }

  update() {
    const length = this.inputTarget.value.length
    const percent = Math.min((length / this.maxValue) * 100, 100)
    const remaining = this.maxValue - length

    // Update the progress bar width
    this.barTarget.style.width = `${percent}%`

    // Update bar color based on how full it is
    this.barTarget.classList.remove("bg-success", "bg-warning", "bg-danger")
    if (percent < 80) {
      this.barTarget.classList.add("bg-success")
    } else if (percent < 100) {
      this.barTarget.classList.add("bg-warning")
    } else {
      this.barTarget.classList.add("bg-danger")
    }

    // Update text label
    this.labelTarget.textContent = `${remaining} characters remaining`
  }
}
