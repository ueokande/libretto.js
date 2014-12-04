class window.Scena.Css

  #
  #
  #
  @create: (id) ->
    css = new Scena.Css
    style = document.createElement("style")
    style.appendChild(document.createTextNode(""))
    style.id = id if id isnt undefined
    window.document.head.appendChild(style)
    css.style = style
    return css

  #
  #
  #
  @findById: (id) ->
    ele = document.getElementById(id)
    return null if ele is null
    if (/style/i).test(ele.tagName)
      css = new Scena.Css
      css.style = ele
      return css
    else
      console.error("The element '##{id}' is existing.  The id was conflicted.")
      return null

  #
  #
  #
  @findOrCreate: (id) ->
    ele = document.getElementById(id)
    return Scena.Css.create(id) if ele is null
    if (/style/i).test(ele.tagName)
      css = new Scena.Css
      css.style = ele
      return css
    else
      console.error("The element '##{id}' is existing.  The id was conflicted.")
      return null

  #
  #
  #
  rules: ->
    return null if @style is null
    return @style.sheet.cssRules if @style.sheet.cssRules isnt undefined
    return @style.sheet.rules

  removeRule: (index) ->
    return @style.sheet.deleteRule(0) if @style.sheet.deleteRule isnt undefined
    @style.sheet.removeRule(0)

  #
  #
  #
  addRule: (selector, styles) ->
    return if @style is null
    len = @rules().length
    if styles is undefined
      cssString = "#{selector} {}"
      @style.sheet.insertRule(cssString, len)
      return @rules()[len].style
    else
      cssString = "#{selector} {"
      cssString += "#{key}: #{value} !important;" for key,value of styles
      cssString += "}"
      @style.sheet.insertRule(cssString, len)

  #
  #
  #
  clearRules: ->
    return if @style is null
    while @rules().length != 0
      @removeRule(0)

  #
  #
  #
  finalize: ->
    return if @style is null
    window.document.head.removeChild(@style)
    @style = null
