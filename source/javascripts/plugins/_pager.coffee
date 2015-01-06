#
# Libretto.Pager module
#
# The Libretto.Pager module provides the pager of slides to search and jump to
# page.  When the presenter press number key, the pager will be shown the
# top of display. The slides are arranged likes list view, and presentation
# will show slide with specified with inputted number or clicked page.
#
# The list of the slide view is not implemented yet, so to jump to objective
# page, use text box.
#

class window.Libretto.Pager extends window.Libretto.Plugin
  constructor: ->
    @inputBox = null
    @show - false
    window.addEventListener('keypress', (e) ->
      return if @shown
      if '0'.charCodeAt(0) <= e.charCode && e.charCode <= '9'.charCodeAt(0)
        chr = String.fromCharCode(e.charCode)
        @inputBox.focus()
        @showPager()
    )

  #
  # Add elements of the pager into body.
  #
  initialize: ->
    input = document.createElement('input')
    input.type = 'text'
    input.style.cssText = '''
      font-size        : 16px;
      text-align       : center;
      width            : 48px;
      height           : 24px;
      background-color : #000;
      color            : #fff;
    '''
    input.onkeydown = @inputKeyEvent

    elem = document.createElement('div')
    elem.style.cssText = '''
      position            : absolute;
      background-color    : #222;
      box-shadow          : 0px 0px 12px #333;
      padding             : 16px;
      paddingTop          : 28px;
      left                : 50%;
      border-radius       : 12px;
      margin-left         : -40px;
      transition-target   : top;
      transition-duration : 300ms;
    '''
    elem.insertBefore(input, null)

    @inputBox = input
    document.body.insertBefore(elem)

    @hidePager()

  
  #
  # Shows the pager.
  #
  showPager: ->
    @inputBox.value = ''
    elem.style.top = '-12px'
    @shown = true
  
  #
  # Hides the pager.
  #
  hidePager: ->
    elem.style.top = '-84px'
    @shown = false
  
  #
  # The event method called on keypress on the text box.
  # Jumps to specified in text box when Enter key is pressed.
  #
  inputKeyEvent: (e) ->
    return if e.keyCode != 13
    
    num = ~~(@inputBox.value)
    viewer = window.Libretto.Viewer.viewer()
    viewer.skipToPage(num - 1)
    @hidePager()
  
