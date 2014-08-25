class Scena.IO extends window.Scena.Plugin
  initialize: =>
    window.addEventListener('keypress', (e) =>
      if e.charCode == '['.charCodeAt(0)
        @core().skipToPrevPage()
      else if e.charCode == ']'.charCodeAt(0)
        @core().skipToNextPage()
    )

    window.addEventListener('keydown', (e)=>
      # TODO: Added Enter key but the Enter is conflicted to pager plugin.
      switch (e.keyCode)
        # case 13:    // Enter
        when 32, 40, 34    # Space, Arrow Down, Page Down
          @core().nextStep()
        when 38, 33    # Arrow Up, Page Up
          @core().prevStep()
        when 36    # Home
          @core().skipToFirstPage()
        when 35    # End
          @core().skipToLastPage()
    )

    window.addEventListener('click', (e) =>
      @core().nextStep()
    )

new window.Scena.IO
