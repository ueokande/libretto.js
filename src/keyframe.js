// Libretto.Keyframe class
//
// The Libretto.Keyframe class provides the keyframe of the animation.
// The animation mechanism is very simple, the style (css) of the element in
// HTML will be overwritten when the keyframe is fired.  To use it, create a
// Libretto.Keyframe from the HTML element object which described as <keyframe>
// tag in HTML.  The <keyframe> tag is distinctive specification in Libretto.js.
// The keyframe will be fired with start() method.

Libretto.Keyframe = class {
  // Constructs a Keyframe object with the given element which is a element
  // contained in <keyframe>.
  constructor(element) {
    this.element = element;
    if (element === undefined) {
      this.element = null;
    }
  }

  // Returns the target of the keyframe.
  target() {
    if (this.element === null) { return null; }
    return this.element.getAttribute("target");
  }

  // Returns the duration of the animation as text.  Return null If the
  // duration is note speficied.
  duration() {
    if (this.element === null) { return null; }
    return this.element.getAttribute("duration");
  }

  properties() {
    if (this.element === null) { return null  }
    let obj = {}
    for (let attr of Array.prototype.slice.call(this.element.attributes)) {
      if (attr.nodeName !== "target" && attr.nodeName !== "duration") {
        obj[attr.nodeName] = attr.value
      }
    }
    return obj
  }

  delay() {
    if (this.element === null) { return null; }
    return this.element.getAttribute("delay")
  }

  timing() {
    if (this.element === null) { return null; }
    return this.element.getAttribute("timing")
  }
}
