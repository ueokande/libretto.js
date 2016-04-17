import Animation from './animation';

// Page class
//
// The Page class provides the page of the slides.  The Page object is created
// from <section> node in HTML.  The css of the page is modified with show(),
// hide(), and neutralStyle() methods.

export default class Page {

  //
  // Returns the number of the pages in the document.
  //
  static count() {
    return this.sectionNodes().length;
  }

  //
  // Returns a Page object of specified index
  //
  static pageAt(index) {
    let element = this.sectionNodes()[index];
    if (typeof element === 'undefined') {
      throw new RangeError('Out of index in sections');
    }
    let obj = new Page();
    obj.element = element;
    return obj;
  }

  static sectionNodes() {
    let children = document.body.children;
    let nodes = [];
    for (let node of Array.prototype.slice.call(children)) {
      if (node.tagName.match(/section/i)) {
        nodes.push(node);
      }
    }
    return nodes;
  }

  //
  // Returns the effect name of the page animation
  //
  animationEffect() {
    return this.element.getAttribute('effect');
  }

  //
  // Returns the duration of the page animation
  //
  animationDuration() {
    return this.element.getAttribute('duration');
  }

  //
  // Returns all attributes.
  //
  animationOptions() {
    let obj = {};
    for (let attr of Array.prototype.slice.call(this.element.attributes)) {
      if (attr.nodeName != 'style' &&
          attr.nodeName != 'effect' &&
          attr.nodeName != 'duration') {
        obj[attr.nodeName] = attr.value;
      }
    }
    return obj;
  }

  //
  // Returns index of the pages
  //
  indexOf() {
    let sections = Page.sectionNodes();
    return sections.indexOf(this.element);
  }

  //
  // Create animation object
  //
  animation() {
    return new Animation(this);
  }
}
