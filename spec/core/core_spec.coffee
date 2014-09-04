describe 'Test of core.coffee', ->
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
    core = new Scena.Core
    expect(window.Scena.core).toBe(core)

    core.initialize()
    expect(core.pages.length).toBe(3)

  it "skips to aspecified page", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(2)

    expect(core.getCurrentIndex()).toBe(2)

  it "fires a keyframe if the page has keyframes", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(0)

    expect(core.currentAnimation.keyframes.length).toBe(2)
    core.nextStep()
    expect(core.currentAnimation.keyframes.length).toBe(1)
    core.nextStep()
    expect(core.currentAnimation.keyframes.length).toBe(0)

  it "moves to a next page if the page has no-keyframes", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(0)

    core.nextStep()
    core.nextStep()
    core.nextStep()
    expect(core.currentAnimation.keyframes.length).toBe(2)
    expect(core.getCurrentIndex()).toBe(1)

  it "skips to aspecified page and remove a keyframe if keyframes remain", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(0)
    core.nextStep()    # of remaining keyframes is 1
    core.skipToPage(2)

    expect(core.getCurrentIndex()).toBe(2)
    expect(core.currentAnimation.keyframes.length).toBe(2)

  xit "animates to aspecified page", ->

  it "skips to aspecified page", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(2)

    expect(core.getCurrentIndex()).toBe(2)

  it "skips to next page", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(1)

    core.skipToNextPage()
    expect(core.getCurrentIndex()).toBe(2)

  it "skips to previous page", ->
    core = new Scena.Core
    core.initialize()
    core.skipToPage(1)

    core.skipToPrevPage()
    expect(core.getCurrentIndex()).toBe(0)

  it "skips to first page", ->
    core = new Scena.Core
    core.initialize()
    core.skipToFirstPage()
    expect(core.getCurrentIndex()).toBe(0)

  it "skips to last page", ->
    core = new Scena.Core
    core.initialize()
    core.skipToLastPage()
    expect(core.getCurrentIndex()).toBe(2)
