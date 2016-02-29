class Libretto.IO extends window.Libretto.Plugin
  initialize: =>
    window.addEventListener('keypress', (e) =>
      viewer = window.Libretto.Viewer.viewer()
      if e.charCode == '['.charCodeAt(0)
        viewer.skipToPrevPage()
      else if e.charCode == ']'.charCodeAt(0)
        viewer.skipToNextPage()
    )

    window.addEventListener('keydown', (e)=>
      # TODO: Added Enter key but the Enter is conflicted to pager plugin.
      viewer = window.Libretto.Viewer.viewer()
      switch (e.keyCode)
        # case 13:    // Enter
        when 32, 40, 34    # Space, Arrow Down, Page Down
          viewer.nextStep()
        when 38, 33    # Arrow Up, Page Up
          viewer.prevStep()
        when 36    # Home
          viewer.skipToFirstPage()
        when 35    # End
          viewer.skipToLastPage()
    )

    window.addEventListener('click', (e) =>
      return if e.button != 0
      viewer = window.Libretto.Viewer.viewer()
      viewer.nextStep()
    )

new window.Libretto.IO
