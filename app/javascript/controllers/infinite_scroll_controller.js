import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infinite-scroll"
export default class extends Controller {
  static values = { next: String }

  connect() {
    if (!this.nextValue) return

    let options = {
      threshold: 0.1,
      rootMargin: "0px",
    }

    let callback = (entries) => {
      if (entries[0].isIntersecting) {
        console.log("Infinite scroll triggered...")
        this.loadMore()
        this.observer.unobserve(this.element)
      }
    }
    this.observer = new IntersectionObserver(callback, options)
    this.observer.observe(this.element)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  loadMore() {
    if (!this.nextValue) return

    console.log("Loading...")
    this.element.innerHTML = "<i class=\"fa-solid fa-kiwi-bird fa-bounce fa-2x\"></i>"

    fetch(this.nextValue, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    }).then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error, status: ${response.status}`);
      }
      return response.text();
    }).then(html => {
      console.log("Rendering...")
      Turbo.renderStreamMessage(html)
      this.element.innerHTML = ""
    })
    .catch(error => {
      console.error('Fetch error:', error);
    });
  }
}
