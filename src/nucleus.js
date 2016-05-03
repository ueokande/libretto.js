import Page from './page';
import Keyframe from './keyframe';

export default class Nucleus {

  //
  // Initializes internal variables and HTML contents.
  //
  constructor() {
    let eventTarget = document.createDocumentFragment();
    ['addEventListener',
     'dispatchEvent',
     'removeEventListener'
    ].forEach((method) => {
      this[method] = eventTarget[method].bind(eventTarget);
    }, this);

    this.nextKeyframe = null;
    this.currentIndex = null;
    this.pageTransition = null;
  }

  getPageIndex() {
    return this.currentIndex;
  }

  //
  // Animate the element of page to next.
  //
  step() {
    if (this.nextKeyframe) {
      this.execNextKeyframe();
    } else if (this.currentIndex + 1 >= Page.count()) {
      return;
    } else {
      let from = this.currentIndex;
      let to = this.currentIndex + 1;
      let transitEvent = new CustomEvent('page.transit', {
        detail: {from, to}
      });
      let changedEvent = new CustomEvent('page.changed', {
        detail: {from, to}
      });
      this.currentIndex += 1;
      let currentPage = Page.pageAt(this.currentIndex);
      this.nextKeyframe = currentPage.element.querySelector('animation > keyframe');

      this.dispatchEvent(transitEvent);
      this.dispatchEvent(changedEvent);
    }
  }

  //
  // Skips to specified page without animation.
  //
  skipTo(index) {
    let pageCount = Page.count();
    if (pageCount === 0) { return; }

    index = Math.max(0, index);
    index = Math.min(pageCount - 1, index);
    if (index === this.currentIndex) { return; }

    let from = this.currentIndex;
    let to = index;
    let skipEvent = new CustomEvent('page.skip', {
      detail: {from, to}
    });
    let changedEvent = new CustomEvent('page.changed', {
      detail: {from, to}
    });
    this.currentIndex = index;
    let currentPage = Page.pageAt(this.currentIndex);
    this.nextKeyframe = currentPage.element.querySelector('animation > keyframe');
    this.dispatchEvent(skipEvent);
    this.dispatchEvent(changedEvent);
  }

  execNextKeyframe() {
    // grouping and calculating delays
    let totalDelay = 0;
    while (true) {
      let keyframe = new Keyframe(this.nextKeyframe);
      let delay = totalDelay;
      if (!keyframe.delay()) {
        delay = totalDelay;
      }
      let target = keyframe.target();
      if (target === null) {
        console.warn('The animation target is not specified.');
      }
      let properties = keyframe.properties();
      let duration = keyframe.duration();
      properties['transition-delay'] = `${delay}ms`;
      properties['transition-duration'] = duration;
      target = `section:nth-of-type(${this.currentIndex + 1}) ${target}`;
      let e = new CustomEvent('keyframe.play', {
        detail: {target, properties}
      });
      this.dispatchEvent(e);

      this.nextKeyframe = this.nextKeyframe.nextElementSibling;
      if (!this.nextKeyframe) {
        break;
      }
      let next = new Keyframe(this.nextKeyframe);
      if (next.timing() !== 'with' && next.timing() !== 'after') {
        break;
      } else if (next.timing() === 'after') {
        totalDelay += Keyframe.timeToMillisecond(keyframe.duration());
      }
    }
  }

  //
  // Skips to next page without animation.
  //
  skipNext() {
    this.skipTo(this.currentIndex + 1);
  }

  //
  // Skips to previous page without animation.
  //
  skipPrev() {
    this.skipTo(this.currentIndex - 1);
  }
}
