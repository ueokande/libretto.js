import Page from './page';
import PageTransition from './page_transition';
import IO from './plugins/io';

export default class Viewer {

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

    this.currentAnimation = null;
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
    this.currentAnimation = currentPage.animation();
    this.currentAnimation.reset();

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
    if (this.currentAnimation.hasNextKeyframe()) {
      this.currentAnimation.nextKeyframe();
    } else {
      this.animateToPage(this.currentIndex + 1);
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
