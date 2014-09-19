#
# Scena.TextItem class
#
class window.Scena.TextItem extends window.Scena.EventListener
  constructor: (@dom) ->
    @textArea = document.createElement('textarea')
    @textArea.addEventListener('keypress', @keydown)
    @textArea.addEventListener('blur', @commit)
    @textArea.style.cssText = window.getComputedStyle(@dom).cssText
    @textArea.style.position = 'absolute'
    @textArea.style.left = "#{@dom.offsetLeft}px"
    @textArea.style.top = "#{@dom.offsetTop}px"
    @textArea.style.width = "#{@dom.offsetWidth}px"
    @textArea.style.height = "#{@dom.offsetHeight}px"
    @textArea.value = @dom.innerHTML
    @textArea.focus()
    @dom.parentNode.appendChild(@textArea)
    @dom.style.visibility = 'hidden'

  keydown: (e) =>
    if e.keyCode == 13 # Enter
      @textArea.blur()
    else
      @update()

  update: (e) =>
    @textArea.style.height = @textArea.style.scrollHeight

  commit: =>
    @dom.innerHTML = @textArea.value
    @dom.style.removeProperty('visibility')
    @textArea.parentNode.removeChild(@textArea)
    @invokeEventListeners('commit')
