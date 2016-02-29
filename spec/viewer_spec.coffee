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
    viewer = new Libretto.Viewer
    expect(window.Libretto.viewer).to.equal(viewer)

  it "skips to aspecified page", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(2)

    expect(viewer.getCurrentIndex()).to.equal(2)

  it "fires a keyframe if the page has keyframes", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(0)

    expect(viewer.currentAnimation.index).to.equal(0)
    viewer.nextStep()
    expect(viewer.currentAnimation.index).to.equal(1)
    viewer.nextStep()
    expect(viewer.currentAnimation.index).to.equal(2)

  it "moves to a next page if the page has no-keyframes", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(0)

    viewer.nextStep()
    viewer.nextStep()
    viewer.nextStep()
    expect(viewer.currentAnimation.keyframes.length).to.equal(2)
    expect(viewer.getCurrentIndex()).to.equal(1)

  it "skips to aspecified page and remove a keyframe if keyframes remain", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(0)
    viewer.nextStep()    # of remaining keyframes is 1
    viewer.skipToPage(2)

    expect(viewer.getCurrentIndex()).to.equal(2)
    expect(viewer.currentAnimation.keyframes.length).to.equal(2)

  xit "animates to aspecified page", ->

  it "skips to aspecified page", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(2)

    expect(viewer.getCurrentIndex()).to.equal(2)

  it "skips to next page", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(1)

    viewer.skipToNextPage()
    expect(viewer.getCurrentIndex()).to.equal(2)

  it "skips to previous page", ->
    viewer = new Libretto.Viewer
    viewer.skipToPage(1)

    viewer.skipToPrevPage()
    expect(viewer.getCurrentIndex()).to.equal(0)

  it "skips to first page", ->
    viewer = new Libretto.Viewer
    viewer.skipToFirstPage()
    expect(viewer.getCurrentIndex()).to.equal(0)

  it "skips to last page", ->
    viewer = new Libretto.Viewer
    viewer.skipToLastPage()
    expect(viewer.getCurrentIndex()).to.equal(2)
