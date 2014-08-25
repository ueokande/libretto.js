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
      @style.sheet.insertRule(cssString, 0)
      return @style.sheet.rules[0].style
    else
      cssString = "#{selector} {"
      cssString += "#{key}: #{value} !important;" for key,value of styles
      cssString += "}"
      @style.sheet.insertRule(cssString, 0)

  #
  #
  #
  clearRules: ->
    return if @style is null
    while @style.sheet.rules.length != 0
      @style.sheet.removeRule(0)

  #
  #
  #
  finalize: ->
    return if @style is null
    window.document.head.removeChild(@style)
    @style = null

