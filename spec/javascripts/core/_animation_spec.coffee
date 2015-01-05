describe 'Test of animation.coffee', ->

  sec0 = null
  sec1 = null
  page0 = null
  page1 = null
  div_by_id = null
  div_by_class = null

  beforeEach ->
    div_by_id = window.document.createElement('div')
    div_by_id.id = 'div_id'
    div_by_class = window.document.createElement('div')
    div_by_class.className = 'div_cls'

    sec0 = window.document.createElement('section')
    sec0.appendChild(div_by_id)
    sec0.appendChild(div_by_class)
    sec1 = window.document.createElement('section')
    window.document.body.appendChild(sec0)
    window.document.body.appendChild(sec1)

    page0 = Scena.Page.pageAt(0)
    page1 = Scena.Page.pageAt(1)

  afterEach ->
    window.document.body.removeChild(sec0)
    window.document.body.removeChild(sec1)
    sec0 = null
    sec1 = null
    page0 = null
    page1 = null
    div_by_id = null
    div_by_class = null

  it 'constructs and reset', ->
    anime = new Scena.Animation(page0)
    style = window.document.getElementById('animation-0')
    expect(style).not.toBeNull()
    anime.css.finalize()

  it 'fires keyframes', ->
    sec0.innerHTML += '''
      <animation>
        <keyframe target="h1" color="red"></keyframe>
        <keyframe target="h2" color="red"></keyframe>
      </animation>
    '''
    anime = new Scena.Animation(page0)

    expect(anime.css.rules().length).toBe(0)
    anime.nextKeyframe()
    expect(anime.css.rules().length).toBe(1)
    anime.css.finalize()

  it 'hasNextKeyframe returns trush value if the keyframes are remaining', ->
    sec1.innerHTML = '''
      <animation>
        <keyframe target='h1' ></keyframe>
        <keyframe target='h2' ></keyframe>
      </animation>
    '''
    anime = new Scena.Animation(page1)
    expect(anime.hasNextKeyframe()).toBeTruthy()
    anime.nextKeyframe()
    expect(anime.hasNextKeyframe()).toBeTruthy()
    anime.nextKeyframe()
    expect(anime.hasNextKeyframe()).toBeFalsy()
    anime.css.finalize()

  it 'does nothing when keyframes are not in the queue', ->
    sec1.innerHTML += '''
      <animation>
        <keyframe target='#div_id'  duration='500ms'/>
        <keyframe target='.div_cls' background-color='green' />
      </animation>
    '''
    anime = new Scena.Animation(page1)
    expect(anime.keyframes.length).toBe(2)
    expect(anime.nextKeyframe()).not.toBeNull()
    expect(anime.nextKeyframe()).not.toBeNull()
    expect(anime.nextKeyframe()).toBeNull()
    anime.css.finalize()

  it 'resets keyframes', ->
    sec1.innerHTML = '''
      <animation>
        <keyframe target='h1' ></keyframe>
      </animation>
    '''
    anime = new Scena.Animation(page1)
    anime.nextKeyframe()
    expect(anime.css.rules().length).toBe(1)
    anime.reset()

    expect(anime.css.rules().length).toBe(0)
    anime.css.finalize()

  it 'pops the next key frame', ->
    cs = (elem) -> window.getComputedStyle(elem)

    sec0.innerHTML += '''
      <animation>
        <keyframe target='#div_id' duration='500ms' delay='500ms' color='red'></keyframe>
      </animation>
    '''
    anime = new Scena.Animation(page0)
    anime.nextKeyframe()
    expect(anime.css.rules()[0].style.transitionDuration).toBe('500ms')
    expect(anime.css.rules()[0].style.transitionDelay).toBe('500ms')
    anime.css.finalize()

  it 'fires a keyframe with the previous keyframe by property timing="with"', ->
    sec0.innerHTML += '''
      <animation>
        <keyframe target='#div_id'                color='red'/></keyframe>
        <keyframe target='.div_cls' timing='with' color='blue'/></keyframe>
      </animation>
    '''
    anime = new Scena.Animation(page0)
    anime.nextKeyframe()
    expect(anime.css.rules()[0].style.color).toBe('red')
    expect(anime.css.rules()[1].style.color).toBe('blue')
    anime.css.finalize()

  it 'fires a keyframe after the previous keyframe by property timing="after"', ->
    sec0.innerHTML += '''
      <animation>
        <keyframe target='#div_id'                 color='red'></keyframe>
        <keyframe target='.div_cls' timing='after' color='blue'></keyframe>
      </animation>
    '''
    anime = new Scena.Animation(page0)
    anime.nextKeyframe()
    expect(anime.css.rules()[0].style.color).toBe('red')
    expect(anime.css.rules()[1].style.color).toBe('blue')
    anime.css.finalize()

  it 'converts the duratin text to millisec', ->
    expect(Scena.Animation.timeToMillisecond("200ms")).toBe(200)
    expect(Scena.Animation.timeToMillisecond("5s")).toBe(5000)
    expect(Scena.Animation.timeToMillisecond("1.4s")).toBe(1400)
    expect(Scena.Animation.timeToMillisecond("abc1.4s")).toBeNull()
    expect(Scena.Animation.timeToMillisecond("x")).toBeNull()
    expect(Scena.Animation.timeToMillisecond("ms")).toBeNull()
    expect(Scena.Animation.timeToMillisecond("")).toBeNull()
