Libretto.Animation = class {
  constructor(page) {
    this.page = page;
    this.keyframes = [];
    this.index = 0;

    let animationNodes = this.page.element.getElementsByTagName('animation');
    for (let anime of Array.prototype.slice.call(animationNodes)) {
      let keyframeNodes = anime.getElementsByTagName('keyframe');
      for (let key of Array.prototype.slice.call(keyframeNodes)) {
        this.keyframes.push(new Libretto.Keyframe(key));
      }
    }
    this.css = Libretto.Css.findOrCreate(`animation-${this.page.indexOf()}`);
  }

  reset() {
    this.css.clearRules();
    this.index = 0;
  }

  hasNextKeyframe() {
    return this.index < this.keyframes.length;
  }

  nextKeyframe() {
    if (!this.hasNextKeyframe()) { return null; }
    return this.execKeyframe(0);
  }

  execKeyframe(afterTime) {
    let keyframe = this.keyframes[this.index];
    this.index += 1;
    let target = keyframe.target();
    if (target === null) {
      console.warn('The animation target is not specified.');
      return null;
    }
    let properties = keyframe.properties();
    let duration = keyframe.duration();
    let delay = '';
    if (keyframe.delay() === null) {
      delay = `${afterTime}ms`;
    } else {
      let deleyStr = Libretto.Animation.timeToMillisecond(keyframe.delay()) + afterTime;
      delay = `${deleyStr}ms`;
    }
    properties['transition-duration'] = duration;
    properties['transition-delay'] = delay;
    let targetStr = `section:nth-of-type(${this.page.indexOf() + 1}) ${target}`;
    this.css.addRule(targetStr, properties);
    if (!this.hasNextKeyframe()) { return 0; }
    let nextKey = this.keyframes[this.index];
    if (nextKey.timing() === 'with') {
      this.execKeyframe(afterTime);
    } else if (nextKey.timing() === 'after') {
      if (duration !== null) {
        afterTime += Libretto.Animation.timeToMillisecond(duration);
      }
      this.execKeyframe(afterTime);
    }
    return 0;
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
};
