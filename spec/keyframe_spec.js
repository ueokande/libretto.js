import Keyframe from '../src/keyframe';

describe('Test of keyframe.coffee', function() {
  it('returns a target of the keyframe when the target is given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    keyframeEle.setAttribute('target', 'h1');
    let keyframe = new Keyframe(keyframeEle);
    expect(keyframe.target()).to.equal('h1');
  });

  it('returns null when the target is not given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    let keyframe = new Keyframe(keyframeEle);
    expect(keyframe.target()).to.be.null;
  });

  it('returns a duration of the keyframe when the duration is given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    keyframeEle.setAttribute('duration', '500ms');
    let keyframe = new Keyframe(keyframeEle);
    expect(keyframe.duration()).to.equal('500ms');
  });

  it('returns null when the duration of the keyframe is not given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    let keyframe = new Keyframe(keyframeEle);
    expect(keyframe.duration()).to.be.null;
  });

  it('returns properties of the keyframe when the properties are given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    keyframeEle.setAttribute('color', 'red');
    keyframeEle.setAttribute('background-color', 'white');
    let keyframe = new Keyframe(keyframeEle);
    let properties = keyframe.properties();
    expect(properties['color']).to.equal('red');
    expect(properties['background-color']).to.equal('white');
  });

  it('returns empty object when the properties are given', function() {
    let keyframeEle = window.document.createElement('keyframe');
    let keyframe = new Keyframe(keyframeEle);
    let properties = keyframe.properties();
    expect(properties).to.be.empty;
  });

  it('throws an error when invalid constructor', function() {
      expect(() => new Keyframe()).to.throw(TypeError);
      expect(() => new Keyframe(123)).to.throw(TypeError);
      expect(() => new Keyframe('elem')).to.throw(TypeError);
  });
});
