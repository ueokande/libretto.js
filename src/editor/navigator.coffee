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
    cloned = doc.pageAt(index).cloneNode(true)
    for element in cloned.getElementsByTagName('*')
      element.removeAttribute('id')
    cloned.removeAttribute('id')
    old = @dom.children[index]
    @dom.insertBefore(cloned, old)
    @dom.removeChild(old)

  updateAll: ->
    @dom.innerHTML = ''
    doc = Scena.Document.currentDocument()
    for p in doc.pages()
      cloned = p.cloneNode(true)
      for element in cloned.getElementsByTagName('*')
        element.removeAttribute('id')
      cloned.removeAttribute('id')
      @dom.appendChild(cloned)

  movePage: (from, to) ->
    doc = Scena.Document.currentDocument()
    doc.movePage(from, to)

    if to > doc.pageCount - 1
      @dom.insertBefore(@dom.children[from], null)
    else
      to = Math.max(to, 0)
      @dom.insertBefore(@dom.children[from], @dom.children[to])

  deletePage: (index) ->
    doc = Scena.Document.currentDocument()
    doc.deletePage(index)
    @dom.removeChild(@dom.children[index])

  addPage: (before) ->
    doc = Scena.Document.currentDocument()
    added = doc.addPage(before)
    cloned = added.cloneNode(true)
    for element in cloned.getElementsByTagName('*')
      element.removeAttribute('id')
    cloned.removeAttribute('id')
    @dom.insertBefore(cloned, @dom.children[before])

  getCurrentPage: ->
    @currentIndex

  setCurrentPage: (index) ->
    @currentIndex = index
