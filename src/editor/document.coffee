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
    return if @container is null
    document.body.removeChild(@container)
    @container = null

  pageAt: (index) ->
    return null if @container is null
    sections = @container.getElementsByTagName('section')
    length = sections.length
    return null if index < 0 or length <= index
    return sections[index]

  pageCount: (index) ->
    return null if @container is null
    return @container.getElementsByTagName('section').length

  toHtmlText: ->
    return null if @container is null
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

  deletePage: (index) ->
    return null if @container is null

  addPage: (to) ->
    return null if @container is null
    to = Math.max(to, 0)
    to = Math.min(to, @pageCount() - 1)
    newElement = document.createElement('section')
    @container.insertBefore(newElement, @pageAt(to))

  movePage: (from, to) ->
    return null if @container is null
    to = Math.max(to, 0)
    to = Math.min(to, @pageCount() - 1)
    section = @pageAt(from)
    @container.removeChild(section)
    @container.insertBefore(section, @pageAt(to))
