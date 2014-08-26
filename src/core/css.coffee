class window.Scena.Css

  #
  #
  #
  constructor: (id) ->
    @style = document.createElement("style")
    @style.appendChild(document.createTextNode(""))
    @style.id = id if id isnt undefined
    window.document.head.appendChild(@style)

  #
  #
  #
  addRule: (selector, styles) ->
    return if @style is null
    if styles is undefined
      cssString = "#{selector} {}"
      @style.textContent += cssString
      return @style.sheet.rules[@style.sheet.rules.length - 1].style
    else
      cssString = "#{selector} {"
      cssString += "#{key}: #{value} !important;" for key,value of styles
      cssString += "}"
      @style.textContent += cssString

  #
  #
  #
  clearRules: ->
    return if @style is null
    @style.textContent = ''

  #
  #
  #
  finalize: ->
    return if @style is null
    window.document.head.removeChild(@style)
    @style = null

