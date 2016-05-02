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

  it('converts the duratin text to millisec', function() {
    expect(Keyframe.timeToMillisecond("200ms")).to.equal(200);
    expect(Keyframe.timeToMillisecond("5s")).to.equal(5000);
    expect(Keyframe.timeToMillisecond("1.4s")).to.equal(1400);
    expect(Keyframe.timeToMillisecond("abc1.4s")).to.be.null;
    expect(Keyframe.timeToMillisecond("x")).to.be.null;
    expect(Keyframe.timeToMillisecond("ms")).to.be.null;
    expect(Keyframe.timeToMillisecond("")).to.be.null;
  });
});
