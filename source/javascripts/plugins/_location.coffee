class window.Scena.Location extends window.Scena.Plugin

  initialize: =>
    window.addEventListener('hashchange', (e)=>
      @applyPage()
    )

    viewer = window.Scena.Viewer.viewer()
    viewer.addCurrentPageChangedListener(=>
      index = viewer.getCurrentIndex()
      @setHash(index)
    )

    @applyPage()

  setHash: (index)=>
    window.location.hash = index + 1

  applyPage: ()->
    num = +(window.location.hash.split('#')[1])
    num = 1 if isNaN(num)
    viewer = window.Scena.Viewer.viewer()
    viewer.skipToPage(num - 1)


new window.Scena.Location

