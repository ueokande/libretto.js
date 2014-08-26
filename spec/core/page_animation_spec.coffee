describe 'Test of page_animation.coffee', ->
  beforeEach ->
    @pageEle1 = window.document.createElement('section')
    @pageEle2 = window.document.createElement('section')
    @prevPage = new Scena.Page(@pageEle1)
    @nextPage = new Scena.Page(@pageEle2)

  afterEach ->

  it 'constructs and destructs a object', ->
    pageAnimation = new Scena.PageAnimation(@prevPage, @nextPage, 'TestPageAnimation')
    styleEle = window.document.getElementById('TestPageAnimation')
    expect(styleEle).not.toBeNull()
    
    pageAnimation.finalize()
    styleEle = window.document.getElementById('TestPageAnimation')
    expect(styleEle).toBeNull()

  it 'switches the page without animation', ->
    pageAnimation = new Scena.PageAnimation(@prevPage, @nextPage, 'TestPageAnimation')
    pageAnimation.switchPage(false)

    expect(@pageEle1.classList.contains('prev')).toBeTruthy()
    expect(@pageEle2.classList.contains('next')).toBeTruthy()

    pageAnimation.finalize()

  xit 'switches the page with animation', ->
