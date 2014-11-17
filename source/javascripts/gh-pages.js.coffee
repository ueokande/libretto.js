window.onload = (e) ->
  editor = window.document.getElementById('editor')
  commit_button= window.document.getElementById('commit-button')
  open_button= window.document.getElementById('open-button')
  preview = window.document.getElementById('preview')

  commit = ->
    preview.srcdoc = editor.value

  open = ->
    win =  window.open('','Scena.js','')
    win.document.write(editor.value)

    # Fire an onload event
    evt = win.document.createEvent('Event')
    evt.initEvent('load', false, false)
    win.dispatchEvent(evt)

  commit_button.onclick = commit
  open_button.onclick = open

  xhr = new XMLHttpRequest()
  xhr.open('GET', '/demo.html')
  xhr.onreadystatechange = ->
    editor.value = xhr.responseText
    commit()
  xhr.send()
