#
# Scena.Navigator class
#

class window.Scena.Navigator
  constructor: (@dom) ->
    @updateAll()
    @currentIndex = null

  finalize: ->
    @dom.innerHTML = ''

  refreshPage: (index) ->
    doc = Scena.Document.currentDocument()
    cloned = cloneAndInsert.call(@, index, doc.pageAt(index))
    @dom.removeChild(@dom.children[index + 1])

  updateAll: ->
    @dom.innerHTML = ''
    doc = Scena.Document.currentDocument()
    for p in doc.pages()
      cloneAndInsert.call(@, doc.pageCount(), p)

  movePage: (from, to) ->
    doc = Scena.Document.currentDocument()
    doc.movePage(from, to)
    @dom.insertBefore(@dom.children[from], @dom.children[to])

  deletePage: (index) ->
    doc = Scena.Document.currentDocument()
    doc.deletePage(index)
    @dom.removeChild(@dom.children[index])

  addPage: (before) ->
    doc = Scena.Document.currentDocument()
    added = doc.addPage(before)
    cloneAndInsert.call(@, before, added)

  cloneAndInsert = (before, element) ->
    cloned = element.cloneNode(true)
    for e in cloned.getElementsByTagName('*')
      e.removeAttribute('id')
    cloned.removeAttribute('id')
    @dom.insertBefore(cloned, @dom.children[before])
    return cloned

  getCurrentPage: ->
    @currentIndex

  setCurrentPage: (index) ->
    @currentIndex = index
