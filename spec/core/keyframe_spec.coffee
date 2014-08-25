describe 'Test of keyframe.coffee', ->
  it 'target() of given target', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframeEle.setAttribute('target', 'h1')
    keyframe = new Scena.Keyframe(keyframeEle)
    expect(keyframe.target()).toBe('h1')

  it 'target() of non-given target', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframe = new Scena.Keyframe(keyframeEle)
    expect(keyframe.target()).toBeNull()

  it 'duration) of given duration', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframeEle.setAttribute('duration', '500ms')
    keyframe = new Scena.Keyframe(keyframeEle)
    expect(keyframe.duration()).toBe('500ms')

  it 'duration() of non-given duration', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframe = new Scena.Keyframe(keyframeEle)
    expect(keyframe.duration()).toBeNull()

  it 'propeties() of given properties', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframeEle.setAttribute('color', 'red')
    keyframeEle.setAttribute('background-color', 'white')
    keyframe = new Scena.Keyframe(keyframeEle)
    properties = keyframe.properties()
    expect(properties['color']).toBe('red')
    expect(properties['background-color']).toBe('white')

  it 'propeties() of non-given properties', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframe = new Scena.Keyframe(keyframeEle)
    properties = keyframe.properties()
    expect(properties).toEqual({})

  it 'target() of invalid constructors', ->
    keyframe1 = new Scena.Keyframe(null)
    keyframe2 = new Scena.Keyframe
    expect(keyframe1.target()).toBeNull()
    expect(keyframe2.target()).toBeNull()

  it 'duration() of invalid constructors', ->
    keyframe1 = new Scena.Keyframe(null)
    keyframe2 = new Scena.Keyframe
    expect(keyframe1.duration()).toBeNull()
    expect(keyframe2.duration()).toBeNull()

  it 'properties() of invalid constructors', ->
    keyframe1 = new Scena.Keyframe(null)
    keyframe2 = new Scena.Keyframe
    expect(keyframe1.properties()).toBeNull()
    expect(keyframe2.properties()).toBeNull()
