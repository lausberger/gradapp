class addFields {
  constructor() {
    this.links = document.querySelectorAll('.add_fields')
    this.iterateLinks()
  }

  iterateLinks() {
    // If there are no links on the page, stop the function from executing.
    if (this.links.length === 0) return
    this.links.forEach(link => {
      link.addEventListener('click', e => {
        this.handleClick(link, e)
      })
    })
  }

  handleClick(link, e) {
    // Stop the function from executing if a link or event were not passed into the function.
    if (!link || !e) return
    e.preventDefault() // Prevent the browser from following the URL.

    let time = new Date().getTime()
    let linkId = link.dataset.id
    let regexp = linkId ? new RegExp(linkId, 'g') : null
    let newFields = regexp ? link.dataset.fields.replace(regexp, time) : null
    newFields ? link.insertAdjacentHTML('beforebegin', newFields) : null
  }
}

window.addEventListener('turbolinks:load', () => new addFields()) // wait for turbolinks
