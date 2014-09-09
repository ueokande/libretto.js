describe 'Test of keyframe_animation.coffee', ->

  div_by_id = null
  div_by_class = null

  beforeEach ->
    div_by_id = window.document.createElement('div')
    div_by_id.id = 'div_id'
    div_by_class = window.document.createElement('div')
    div_by_class.className = 'div_cls'
    window.document.body.appendChild(div_by_id)
    window.document.body.appendChild(div_by_class)

  afterEach ->
    window.document.body.removeChild(div_by_id)
    window.document.body.removeChild(div_by_class)
    div_by_id = null
    div_by_class = null

  it 'constructs and finalizes', ->
    animationEle = window.document.createElement('animation')
    animationEle.innerHTML = '''
      <keyframe target='#div_id'  duration='500ms'/>
      <keyframe target='.div_cls' background-color='green' />
    '''
    anime = new Scena.KeyframeAnimation(animationEle, 'animation_style_test')
    style = window.document.getElementById('animation_style_test')
    expect(style).not.toBeNull()

    anime.finalize()
    style = window.document.getElementById('animation_style_test')
    expect(style).toBeNull()

  it 'pops the next key frame', (done) ->
    animationEle = window.document.createElement('animation')
    animationEle.innerHTML = '''
      <keyframe target='#div_id'  duration='500ms'/>
      <keyframe target='.div_cls' background-color='green' />
      <keyframe target='#div_id'  duration='500ms' opacity='0'/>
    '''
    anime = new Scena.KeyframeAnimation(animationEle)
    anime.nextKeyframe()
    expect(window.getComputedStyle(div_by_id).transitionDuration).toBe('0.5s')
    anime.nextKeyframe()
    expect(window.getComputedStyle(div_by_class).backgroundColor).toBe('rgb(0, 128, 0)')

    expect(+window.getComputedStyle(div_by_id).opacity).toBe(1)
    anime.nextKeyframe()
    setTimeout(->
      expect(+window.getComputedStyle(div_by_id).opacity).toBeGreaterThan(0)
      expect(+window.getComputedStyle(div_by_id).opacity).toBeLessThan(1)
    ,250)
    setTimeout(->
      expect(+window.getComputedStyle(div_by_id).opacity).toBe(0)
      anime.finalize()
      done()
    ,600)


  it 'does nothing when keyframes are not in the queue', ->
    animationEle = window.document.createElement('animation')
    animationEle.innerHTML = '''
      <keyframe target='#div_id'  duration='500ms'/>
      <keyframe target='.div_cls' background-color='green' />
    '''
    anime = new Scena.KeyframeAnimation(animationEle)
    expect(anime.nextKeyframe()).not.toBeNull()
    expect(anime.nextKeyframe()).not.toBeNull()
    expect(anime.nextKeyframe()).toBeNull()
    anime.finalize()


  it 'hasNextKeyframe', ->
    animationEle = window.document.createElement('animation')
    animationEle.innerHTML = '''
      <keyframe target='#div_id'  duration='500ms'/>
      <keyframe target='.div_cls' background-color='green' />
    '''
    anime = new Scena.KeyframeAnimation(animationEle)

    expect(anime.hasNextKeyframe()).toBeTruthy()

    anime.nextKeyframe()
    expect(anime.hasNextKeyframe()).toBeTruthy()

    anime.nextKeyframe()
    expect(anime.hasNextKeyframe()).toBeFalsy()

    anime.finalize()

  it 'does nothing after the finalize() is called', ->
    animationEle = window.document.createElement('animation')
    animationEle.innerHTML = '''
      <keyframe target='#div_id'  duration='500ms'/>
      <keyframe target='.div_cls' background-color='green' />
    '''
    anime = new Scena.KeyframeAnimation(animationEle)
    anime.finalize()

    expect(anime.hasNextKeyframe()).toBeNull()

