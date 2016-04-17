import Css from './css';

export default class PageTransition {
  constructor(prevIndex, nextIndex, nextPage, cssId) {
    this.prevIndex = prevIndex;
    this.nextIndex = nextIndex;
    this.nextPage = nextPage;
    this.pageAnimeCss = Css.findOrCreate(cssId);
  }

  finalize() {
    this.pageAnimeCss.finalize();
  }

  switchPage(animationEnable) {
    if (animationEnable) {
      this.animatePage();
    } else {
      this.noAnimatePage();
    }
  }

  noAnimatePage() {
    this.execAnime();
  }

  animatePage() {
    let effectName = this.nextPage.animationEffect();
    let duration = this.nextPage.animationDuration();
    let options = this.nextPage.animationOptions();

    let effect = null;
    if (effectName !== null) {
      effect = Libretto.loadPageEffect(effectName);
    }
    if (effect === null) {
      console.warn(`No such page effect : ${effectName}`);
    }

    if (effect === null) {
      this.execAnime();
    } else {
      this.execAnime(effect, duration, options);
    }
  }

  execAnime(effect, duration, options) {
    this.pageAnimeCss.clearRules();
    let prevStyle = null;
    if (this.prevIndex !== null) {
      prevStyle = this.pageAnimeCss.addRule(`section:nth-of-type(${this.prevIndex + 1})`);
      prevStyle.visibility = 'visible';
      prevStyle.zIndex = 0;
    }
    let nextStyle = this.pageAnimeCss.addRule(`section:nth-of-type(${this.nextIndex + 1})`);
    nextStyle.visibility = 'visible';
    nextStyle.zIndex = 1;

    if (typeof effect === 'undefined') { return; }
    if (effect.hasOwnProperty('before')) {
      effect.before(prevStyle, nextStyle, duration, options);
    }
    setTimeout(() => { effect.exec(prevStyle, nextStyle, duration, options); },
              50);  // 50ms is hack to run on Firefox
  }
}
