window.onload = (e) => {
  let editor = window.document.getElementById('editor')
  let commit_button= window.document.getElementById('commit-button')
  let open_button= window.document.getElementById('open-button')
  let preview = window.document.getElementById('preview')

  let commit = () => {
    preview.srcdoc = editor.value
  }

  let open = () => {
    let win =  window.open('','Libretto.js','')
    win.document.write(editor.value)

    // Fire an onload event
    evt = win.document.createEvent('Event')
    evt.initEvent('load', false, false)
    win.dispatchEvent(evt)
  }

  commit_button.onclick = commit
  open_button.onclick = open

  let xhr = new XMLHttpRequest()
  xhr.open('GET', 'demo.html')
  xhr.onreadystatechange = () =>  {
    editor.value = xhr.responseText
    commit()
  }
  xhr.send()
}
