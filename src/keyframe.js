// Libretto.Keyframe class
//
// The Libretto.Keyframe class provides the keyframe of the animation.
// The animation mechanism is very simple, the style (css) of the element in
// HTML will be overwritten when the keyframe is fired.  To use it, create a
// Libretto.Keyframe from the HTML element object which described as <keyframe>
// tag in HTML.  The <keyframe> tag is distinctive specification in Libretto.js.
// The keyframe will be fired with start() method.

export default class Keyframe {
  // Constructs a Keyframe object with the given element which is a element
  // contained in <keyframe>.
  constructor(element) {
    if (!(element instanceof Element)) {
      throw new TypeError('Argument 1 does not implement interface Element');
    }
    this.element = element;
  }

  // Returns the target of the keyframe.
  target() {
    return this.element.getAttribute('target');
  }

  // Returns the duration of the animation as text.  Return null If the
  // duration is note speficied.
  duration() {
    return this.element.getAttribute('duration');
  }

  properties() {
    let obj = {};
    for (let attr of Array.prototype.slice.call(this.element.attributes)) {
      if (attr.nodeName !== 'target' && attr.nodeName !== 'duration') {
        obj[attr.nodeName] = attr.value;
      }
    }
    return obj;
  }

  delay() {
    return this.element.getAttribute('delay');
  }

  timing() {
    return this.element.getAttribute('timing');
  }

  // Converts time descrived as string to millisecond
  // timeToMs("200ms")    // return 200
  // timeToMs("5s")       // return 5000
  // timeToMs("1.4s")     // return 1400
  static timeToMillisecond(time) {
    if (time.length === 0) { return null; }
    let msec1 = Number(time.split('ms')[0]);
    let msec2 = time.split('s')[0] * 1000;
    let num = msec1 || msec2;
    if (isNaN(num)) { return null; }
    return num;
  }

}
