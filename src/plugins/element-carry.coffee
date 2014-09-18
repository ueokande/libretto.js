class Scena.ElementCarry extends window.Scena.Plugin

  initialize: =>
    @css = new Scena.Css('element-carry')
    @css.addRule('.element-carry-highlight', {'box-shadow':'0 0 8px #44f'})

    @targetObject = null
    @prevHovered = null
    window.addEventListener('mousedown', (e) => @mouseDown(e.button, e.clientX, e.clientY))
    window.addEventListener('mouseup', (e) => @mouseUp(e.button, e.clientX, e.clientY))
    window.addEventListener('mousemove', (e) => @mouseMove(e.button, e.clientX, e.clientY))

  stringPxToInt: (string) ->
    return 0 if string.length == 0
    return +(string.split('px')[0])
  
  highlightElement: (element) ->
    rect = element.getBoundingClientRect()
    @highlight.style.left = rect.left
    @highlight.style.top = rect.top
    @highlight.style.width = rect.width
    @highlight.style.height = rect.height

  underElement: (x, y) ->
    element = window.document.elementFromPoint(x, y)
    if element.tagName.match(/thead|tbody|tr|td|th/i)
      element = ((ele, tagname) ->
        parent = ele.parentElement
        return null if parent is null
        return parent if parent.tagName.match(new RegExp(tagname, 'i'))
        arguments.callee(parent, tagname))(element, 'table')
    return element

  mouseDown: (button, x, y) =>
    return if button != 1
    element = @underElement(x, y)
    return if element.tagName.match(/section/i)
    @targetObject = element
    @zoom = +getComputedStyle(document.body).zoom
    @mouseOriginX = x
    @mouseOriginY = y
    @initialX = +window.getComputedStyle(@targetObject).marginLeft.split('px')[0]
    @initialY = +window.getComputedStyle(@targetObject).marginTop.split('px')[0]

  mouseUp: (button, x, y) =>
    return if button != 1
    @targetObject = null

  mouseMove: (button, x, y) =>
    if @targetObject isnt null
      deltaX = (x - @mouseOriginX) / @zoom
      deltaY = (y - @mouseOriginY) / @zoom
      if Math.abs(deltaX) < 8
        @targetObject.style.removeProperty('margin-left')
      else
        @targetObject.style.marginLeft = @initialX + deltaX
      if Math.abs(deltaY) < 8
        @targetObject.style.removeProperty('margin-top')
      else
        @targetObject.style.marginTop = deltaY
      hovered = @targetObject
    else
      hovered = @underElement(x, y)

    if @prevHovered != hovered
      @prevHovered.classList.remove('element-carry-highlight') if @prevHovered isnt null
      hovered.classList.add('element-carry-highlight')
      @prevHovered = hovered


#  This plugin will potentially be removed.
# new window.Scena.ElementCarry
