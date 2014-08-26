describe 'Test of page_animation.coffee', ->
  beforeEach ->
    @pageEle1 = window.document.createElement('section')
    @pageEle2 = window.document.createElement('section')
    @pageEle1.style.position = 'absolute'
    @pageEle2.style.position = 'absolute'
    window.document.body.appendChild(@pageEle1)
    window.document.body.appendChild(@pageEle2)

    @prevPage = new Scena.Page(@pageEle1)
    @nextPage = new Scena.Page(@pageEle2)

  afterEach ->
    window.document.body.removeChild(@pageEle1)
    window.document.body.removeChild(@pageEle2)
    @prevPage = null
    @nextPage = null
    @pageEle1 = null
    @pageEle2 = null

  it 'constructs and destructs a object', ->
    pageAnimation = new Scena.PageAnimation(0, 1, @nextPage, 'TestPageAnimation')
    styleEle = window.document.getElementById('TestPageAnimation')
    expect(styleEle).not.toBeNull()
    
    pageAnimation.finalize()
    styleEle = window.document.getElementById('TestPageAnimation')
    expect(styleEle).toBeNull()

  it 'switches the page without animation', ->
    pageAnimation = new Scena.PageAnimation(0, 1, @nextPage, 'TestPageAnimation')
    pageAnimation.switchPage(false)

    expect(window.getComputedStyle(@pageEle1).zIndex) \
      .toBeLessThan(window.getComputedStyle(@pageEle2).zIndex)

    pageAnimation.finalize()

  xit 'switches the page with animation', ->
