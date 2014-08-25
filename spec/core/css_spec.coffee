describe 'Test of css.coffee', ->

  beforeEach ->
  afterEach ->

  it 'construct and destruct', ->
    css = new Scena.Css('tested_css')
    styleEle = window.document.getElementById('tested_css')
    expect(styleEle).not.toBeNull()

    css.finalize()
    styleEle = window.document.getElementById('tested_css')
    expect(styleEle).toBeNull()

  it 'addRule with specifying style', ->
    css = new Scena.Css('tested_css')
    css.addRule('h2', {'color':'red'})
    css.addRule('h3', {'background-color':'blue'})
    expect(css.style.sheet.rules.length).toBe(2)
    expect(css.style.sheet.rules[0].style.backgroundColor).toBe('blue')
    expect(css.style.sheet.rules[1].style.color).toBe('red')
    css.finalize()

  it 'applying on-site HTML', ->
    css = new Scena.Css('tested_css')
    css.addRule('#div_id', {'color':'red'})
    css.addRule('.div_cls', {'background-color':'blue'})

    div = window.document.getElementById('div_id')
    expect(window.getComputedStyle(div).color).toBe('rgb(255, 0, 0)')
    div = window.document.getElementsByClassName('div_cls')[0]
    expect(window.getComputedStyle(div).backgroundColor).toBe('rgb(0, 0, 255)')

    css.finalize()

  it 'clearRule', ->
    css = new Scena.Css('tested_css')
    css.addRule('h2', {'color':'red'})
    css.addRule('h3', {'background-color':'blue'})
    css.clearRules()
    expect(css.style.sheet.rules.length).toBe(0)
    css.finalize()

