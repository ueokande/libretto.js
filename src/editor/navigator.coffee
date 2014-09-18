#
# Scena.Navigator class
#

class window.Scena.Navigator
  constructor: (@dom) ->
    @updateAll()
    @currentIndex = null
    @draggedEle = null

    @currentPageChangedListeners = []

  finalize: ->
    @dom.innerHTML = ''

  refreshPage: (index) ->
    doc = Scena.Document.currentDocument()
    capsule = cloneAndInsert.call(@, index, doc.pageAt(index))
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
    innerCapsule = document.createElement('div')
    innerCapsule.appendChild(cloned)
    innerCapsule.classList.add('innerCapsule')
    outerCapsule = document.createElement('div')
    outerCapsule.setAttribute('draggable', 'true')
    outerCapsule.addEventListener('mousedown', @pageMouseDown, false)
    outerCapsule.addEventListener('dragstart', @pageDragStart, false)
    outerCapsule.addEventListener('dragend', @pageDragEnd, false)
    outerCapsule.addEventListener('dragenter', @pageDragEnter, false)
    outerCapsule.addEventListener('dragover', @pageDragOver, false)
    outerCapsule.addEventListener('dragleave', @pageDragLeave, false)
    outerCapsule.addEventListener('drop', @pageDrop, false)
    outerCapsule.classList.add('outerCapsule')
    outerCapsule.appendChild(innerCapsule)
    @dom.insertBefore(outerCapsule, @dom.children[before])
    return outerCapsule

  getCurrentIndex: ->
    @currentIndex

  setCurrentIndex: (index) =>
    return if @currentIndex == index
    @currentIndex = index
    for c in @dom.children
      c.classList.remove('active')
    @dom.children[index].classList.add('active')
    listener() for listener in @currentPageChangedListeners

  indexOfChild: (node) ->
    n = 0
    n++ while (node = node.previousSibling)
    return n

  pageMouseDown: (e) =>
    @setCurrentIndex(@indexOfChild(e.target))

  pageDragStart: (e) =>
    e.dataTransfer.effectAllower = 'move'
    @draggedEle = e.target
    @draggedEle.classList.add('dragged')

  pageDragEnd: (e) =>
    for c in @dom.children
      c.classList.remove('over')
    @draggedEle.classList.remove('dragged')
    @draggedEle = null

  pageDragEnter: (e) =>
    return if e.target == @draggedEle
    return if e.target == @draggedEle.nextSibling
    e.target.classList.add('over')

  pageDragOver: (e) ->
    e.preventDefault()
    e.dataTransfer.dropEffect = 'move'

  pageDragLeave: (e) ->
    @.classList.remove('over')

  pageDrop: (e) =>
    e.stopPropagation()
    return if @draggedEle == null
    indexFrom = @indexOfChild(@draggedEle)
    indexTo = @indexOfChild(e.target)
    @movePage(indexFrom, indexTo)
    return false

  addCurrentPageChangedListener: (listener) ->
    @currentPageChangedListeners.push(listener)
