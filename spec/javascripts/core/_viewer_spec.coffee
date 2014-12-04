describe 'Test of viewer.coffee', ->
  elements = null


  beforeEach ->
    elements = [null, null, null]
    for i,_ of elements
      elements[i] =  window.document.createElement('section')
      elements[i].innerHTML = '''
      <animation>
        <keyframe target='h1'>
        <keyframe target='h2'>
      </animation>
      '''
      window.document.body.appendChild(elements[i])

  afterEach ->
    for i,_ of elements
      window.document.body.removeChild(elements[i])
    elements = null

  it "initializes a object", ->
    viewer = new Scena.Viewer
    expect(window.Scena.viewer).toBe(viewer)

  it "skips to aspecified page", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(2)

    expect(viewer.getCurrentIndex()).toBe(2)

  it "fires a keyframe if the page has keyframes", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(0)

    expect(viewer.currentAnimation.index).toBe(0)
    viewer.nextStep()
    expect(viewer.currentAnimation.index).toBe(1)
    viewer.nextStep()
    expect(viewer.currentAnimation.index).toBe(2)

  it "moves to a next page if the page has no-keyframes", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(0)

    viewer.nextStep()
    viewer.nextStep()
    viewer.nextStep()
    expect(viewer.currentAnimation.keyframes.length).toBe(2)
    expect(viewer.getCurrentIndex()).toBe(1)

  it "skips to aspecified page and remove a keyframe if keyframes remain", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(0)
    viewer.nextStep()    # of remaining keyframes is 1
    viewer.skipToPage(2)

    expect(viewer.getCurrentIndex()).toBe(2)
    expect(viewer.currentAnimation.keyframes.length).toBe(2)

  xit "animates to aspecified page", ->

  it "skips to aspecified page", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(2)

    expect(viewer.getCurrentIndex()).toBe(2)

  it "skips to next page", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(1)

    viewer.skipToNextPage()
    expect(viewer.getCurrentIndex()).toBe(2)

  it "skips to previous page", ->
    viewer = new Scena.Viewer
    viewer.skipToPage(1)

    viewer.skipToPrevPage()
    expect(viewer.getCurrentIndex()).toBe(0)

  it "skips to first page", ->
    viewer = new Scena.Viewer
    viewer.skipToFirstPage()
    expect(viewer.getCurrentIndex()).toBe(0)

  it "skips to last page", ->
    viewer = new Scena.Viewer
    viewer.skipToLastPage()
    expect(viewer.getCurrentIndex()).toBe(2)
