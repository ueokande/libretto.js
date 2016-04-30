Libretto.Viewer = class {

  static viewer() {
    return Libretto.viewer;
  }

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

    Libretto.viewer = this;
  }

  getCurrentIndex() {
    return this.currentIndex;
  }

  //
  // Skips to specified page without animation.
  //
  skipToPage(index) {
    if (Libretto.Page.count() === 0) { return; }
    this.switchPage(index, false);
  }

  //
  //
  //
  animateToPage(index) {
    if (Libretto.Page.count() === 0) { return; }
    this.switchPage(index, true);
  }

  //
  //
  //
  switchPage(index, animationEnable) {
    index = Math.max(0, index);
    index = Math.min(Libretto.Page.count() - 1, index);
    if (index === this.currentIndex) { return; }

    let prevIndex = this.currentIndex;
    let nextIndex = index;
    let currentPage = Libretto.Page.pageAt(index);
    this.currentIndex = index;
    this.currentAnimation = currentPage.animation();
    this.currentAnimation.reset();

    if (this.pageTransition !== null) { this.pageTransition.finalize(); }
    this.pageTransition = new Libretto.PageTransition(prevIndex,
                                                      nextIndex,
                                                      currentPage);
    this.pageTransition.switchPage(animationEnable);

    this.dispatchEvent(new Event('currentPageChanged'));
  }

  //
  // Animate the element of page to next.
  //
  nextStep() {
    if (this.currentAnimation.hasNextKeyframe()) {
      this.currentAnimation.nextKeyframe();
    } else {
      this.animateToPage(this.currentIndex + 1);
    }
  }

  //
  // Skip to previous step of page.
  //
  prevStep() {
    this.skipToPrevPage();
  }

  //
  // Skips to next page without animation.
  //
  skipToNextPage() {
    this.skipToPage(this.currentIndex + 1);
  }

  //
  // Skips to previous page without animation.
  //
  skipToPrevPage() {
    this.skipToPage(this.currentIndex - 1);
  }

  //
  // Skips to last page without animation.
  //
  skipToFirstPage() {
    this.skipToPage(0);
  }

  //
  // Skips to last page without animation.
  //
  skipToLastPage() {
    this.skipToPage(Libretto.Page.count() - 1);
  }
};

new Libretto.Viewer();
