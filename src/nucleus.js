import Page from './page';
import PageTransition from './page_transition';
import Css from './css';
import Keyframe from './keyframe';
import IO from './plugins/io';

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

    this.animationCss = null;
    this.nextKeyframe = null;
    this.currentIndex = null;
    this.pageTransition = null;

    new IO(window);
  }

  getCurrentIndex() {
    return this.currentIndex;
  }

  //
  // Skips to specified page without animation.
  //
  skipTo(index) {
    if (Page.count() === 0) { return; }
    this.switchPage(index, false);
  }

  //
  //
  //
  animateToPage(index) {
    if (Page.count() === 0) { return; }
    this.switchPage(index, true);
  }

  //
  //
  //
  switchPage(index, animationEnable) {
    index = Math.max(0, index);
    index = Math.min(Page.count() - 1, index);
    if (index === this.currentIndex) { return; }

    let prevIndex = this.currentIndex;
    let nextIndex = index;
    let currentPage = Page.pageAt(index);
    this.currentIndex = index;

    this.animationCss = Css.findOrCreate(`animation-${this.currentIndex}`);
    this.animationCss.clearRules();
    this.nextKeyframe = currentPage.element.querySelector('animation > keyframe');

    if (this.pageTransition !== null) { this.pageTransition.finalize(); }
    this.pageTransition = new PageTransition(prevIndex,
                                             nextIndex);
    this.pageTransition.switchPage(animationEnable);

    this.dispatchEvent(new Event('currentPageChanged'));
  }

  //
  // Animate the element of page to next.
  //
  step() {
    if (this.nextKeyframe) {
      this.execNextKeyframe(0);
    } else {
      this.animateToPage(this.currentIndex + 1);
    }
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
      let targetStr = `section:nth-of-type(${this.currentIndex + 1}) ${target}`;
      this.animationCss.addRule(targetStr, properties);

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
