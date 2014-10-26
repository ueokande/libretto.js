class window.Scena.Presentation
  constructor: (@container) ->

  loadFromText: (content) ->
    @container.innerHTML = content

  pageAt: (index) ->
    return null if @container is null
    sections = @container.getElementsByTagName('section')
    length = sections.length
    return null if index < 0 or length <= index
    return sections[index]

  pageCount: (index) ->
    return null if @container is null
    return @container.getElementsByTagName('section').length

  pages: () ->
    return null if @container is null
    return @container.getElementsByTagName('section')

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
    @container.removeChild(@pageAt(index))

  insertPage: (to) ->
    return null if @container is null
    to = Math.max(to, 0)
    newElement = document.createElement('section')
    @container.insertBefore(newElement, @pageAt(to))
    return newElement

  movePage: (from, to) ->
    return null if @container is null
    to = Math.max(to, 0)
    @container.insertBefore(@pageAt(from), @pageAt(to))

app = angular.module('scena_editor', [])
app.factory 'presentation', ->
  container = document.createElement('div')
  container.id = 'scena-editor-container'
  window.document.body.appendChild(container)
  return new window.Scena.Presentation(container)
