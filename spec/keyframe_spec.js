describe('Test of keyframe.coffee', function() {
  it('returns a target of the keyframe when the target is given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    keyframeEle.setAttribute('target', 'h1');
    let keyframe = new Libretto.Keyframe(keyframeEle);
    expect(keyframe.target()).to.equal('h1');
  });

  it('returns null when the target is not given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    let keyframe = new Libretto.Keyframe(keyframeEle);
    expect(keyframe.target()).to.be["null"];
  });

  it('returns a duration of the keyframe when the duration is given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    keyframeEle.setAttribute('duration', '500ms');
    let keyframe = new Libretto.Keyframe(keyframeEle);
    expect(keyframe.duration()).to.equal('500ms');
  });

  it('returns null when the duration of the keyframe is not given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    let keyframe = new Libretto.Keyframe(keyframeEle);
    expect(keyframe.duration()).to.be["null"];
  });

  it('returns properties of the keyframe when the properties are given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    keyframeEle.setAttribute('color', 'red');
    keyframeEle.setAttribute('background-color', 'white');
    let keyframe = new Libretto.Keyframe(keyframeEle);
    let properties = keyframe.properties();
    expect(properties['color']).to.equal('red');
    expect(properties['background-color']).to.equal('white');
  });

  it('returns empty object when the properties are given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    let keyframe = new Libretto.Keyframe(keyframeEle);
    let properties = keyframe.properties();
    expect(properties).to.be.empty;
  });

  it('returns null target if invalid constructor', function() {
    let keyframe1 = new Libretto.Keyframe(null);
    let keyframe2 = new Libretto.Keyframe;
    expect(keyframe1.target()).to.be["null"];
    expect(keyframe2.target()).to.be["null"];
  });

  it('returns null duration if invalid constructor', function() {
    let keyframe1 = new Libretto.Keyframe(null);
    let keyframe2 = new Libretto.Keyframe;
    expect(keyframe1.duration()).to.be["null"];
    expect(keyframe2.duration()).to.be["null"];
  });

  it('returns null properties if invalid constructor', function() {
    let keyframe1 = new Libretto.Keyframe(null);
    let keyframe2 = new Libretto.Keyframe;
    expect(keyframe1.properties()).to.be["null"];
    expect(keyframe2.properties()).to.be["null"];
  });
});
