class removeFields {
  constructor() {
    this.iterateLinks()
  }

  iterateLinks() {
    document.addEventListener('click', e => {
      if (e.target && e.target.className === 'remove_fields') {
        this.handleClick(e.target, e)
      }
    })
  }

  handleClick(link, e) {
    if (!link || !e) return // Stop the function from executing if a link or event were not passed into the function.
    e.preventDefault() // Prevent browser from following the URL.

    let fieldParent = link.closest('.nested-fields')
    let deleteField = fieldParent
      ? fieldParent.querySelector('input[type="hidden"]')
      : null

    if (deleteField) {
      deleteField.value = 1
      fieldParent.style.display = 'none'
    }
  }
}

window.addEventListener('turbolinks:load', () => new removeFields()) // wait for turbolinks
