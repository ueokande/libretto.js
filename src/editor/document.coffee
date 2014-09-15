#
# Scena.Document class
# 

class window.Scena.Document
  constructor: (contents) ->
    @container = document.createElement('div')
    @container.id = 'scena-editor-container'
    @container.innerHTML = contents
    document.body.appendChild(@container)

  finalize: ->
    document.body.removeChild(@container)

  pageAt: (index) ->
    sections = @container.getElementsByTagName('section')
    return null if sections.length <= index
    return sections[index]

  toHtmlText: ->
    headContents = ''
    bodyContents = ''
    for c in @container.children
      unless c.tagName.match('section')
        headContents += c.outterHTML + '\n'
      else
        bodyContents += c.outterHTML + '\n'

    "<html>
      <head>#{headContents}</head>
      <body>#{bodyContents}</body>
    </html>"

  movePage: (from, to) ->

  deletePage: (index) ->

  addPage: (before) ->
