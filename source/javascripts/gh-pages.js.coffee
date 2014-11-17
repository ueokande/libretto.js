window.onload = (e) ->
  editor = window.document.getElementById('editor')
  commit_button= window.document.getElementById('commit-button')
  preview = window.document.getElementById('preview')

  commit = ->
    preview.srcdoc = editor.value

  commit_button.onclick = -> commit()

  xhr = new XMLHttpRequest()
  xhr.open('GET', '/demo.html')
  xhr.onreadystatechange = ->
    editor.value = xhr.responseText
    commit()
  xhr.send()
