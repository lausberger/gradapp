// app/javascript/packs/nested-forms/removeFields.js
class removeFields {
  // This executes when the function is instantiated.
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
    // Find the parent wrapper for the set of nested fields.
    let fieldParent = link.closest('.nested-fields')
    // If there is a parent wrapper, find the hidden delete field.
    let deleteField = fieldParent
      ? fieldParent.querySelector('input[type="hidden"]')
      : null
    // If there is a delete field, update the value to `1` and hide the corresponding nested fields.
    if (deleteField) {
      deleteField.value = 1
      fieldParent.style.display = 'none'
    }
  }
}

// Wait for turbolinks to load, otherwise `document.querySelectorAll()` won't work
window.addEventListener('turbolinks:load', () => new removeFields())
