describe 'Test of keyframe.coffee', ->

  it 'returns a target of the keyframe when the target is given', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframeEle.setAttribute('target', 'h1')
    keyframe = new Libretto.Keyframe(keyframeEle)
    expect(keyframe.target()).toBe('h1')

  it 'returns null when the target is not given', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframe = new Libretto.Keyframe(keyframeEle)
    expect(keyframe.target()).toBeNull()

  it 'returns a duration of the keyframe when the duration is given', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframeEle.setAttribute('duration', '500ms')
    keyframe = new Libretto.Keyframe(keyframeEle)
    expect(keyframe.duration()).toBe('500ms')

  it 'returns null when the duration of the keyframe is not given', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframe = new Libretto.Keyframe(keyframeEle)
    expect(keyframe.duration()).toBeNull()

  it 'returns properties of the keyframe when the properties are given', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframeEle.setAttribute('color', 'red')
    keyframeEle.setAttribute('background-color', 'white')
    keyframe = new Libretto.Keyframe(keyframeEle)
    properties = keyframe.properties()
    expect(properties['color']).toBe('red')
    expect(properties['background-color']).toBe('white')

  it 'returns empty object when the properties are given', ->
    keyframeEle = window.document.createElement('keyframe')
    keyframe = new Libretto.Keyframe(keyframeEle)
    properties = keyframe.properties()
    expect(properties).toEqual({})

  it 'returns null target if invalid constructor', ->
    keyframe1 = new Libretto.Keyframe(null)
    keyframe2 = new Libretto.Keyframe
    expect(keyframe1.target()).toBeNull()
    expect(keyframe2.target()).toBeNull()

  it 'returns null duration if invalid constructor', ->
    keyframe1 = new Libretto.Keyframe(null)
    keyframe2 = new Libretto.Keyframe
    expect(keyframe1.duration()).toBeNull()
    expect(keyframe2.duration()).toBeNull()

  it 'returns null properties if invalid constructor', ->
    keyframe1 = new Libretto.Keyframe(null)
    keyframe2 = new Libretto.Keyframe
    expect(keyframe1.properties()).toBeNull()
    expect(keyframe2.properties()).toBeNull()
