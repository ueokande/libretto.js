// Dissolve page effect
// Optional arguments
// - direction ..... Direction of movement
//     right  ... Left to Right
//     left   ... Right to Left
//     up ... Top to Bottom
//     down ... Bottom to Top
Libretto.registerPageEffect('dissolve', {
  before(prevStyle, nextStyle, duration, _options) {
    nextStyle.opacity = '0';
  },
  exec(prevStyle, nextStyle, duration, _options) {
    nextStyle.transitionDuration = duration;
    nextStyle.opacity = '1';
  }
});

// MoveIn page Effect
// Optional arguments
// - direction ..... Direction of movement
//     right  ... Left to Right
//     left   ... Right to Left
//     up ... Top to Bottom
//     down ... Bottom to Top
Libretto.registerPageEffect('move-in', {
  before(prevStyle, nextStyle, duration, options) {
    let origin = {
      left: ['100%', '0%'],
      right: ['-100%', '0%'],
      up: ['0%', '100%'],
      down: ['0%', '-100%']
    }[options.direction];
    if (origin === null) {
      if (options.direction !== null) {
        console.warn('Invalid value of direction:', options.direction);
      }
      origin = ['100%', '0%'];
    }
    nextStyle.left = origin[0];
    nextStyle.top = origin[1];
  },
  exec(prevStyle, nextStyle, duration, options) {
    if (duration === null) {
      nextStyle.transitionDuration = '1s';
    } else {
      nextStyle.transitionDuration = duration;
    }
    nextStyle.left = '0%';
    nextStyle.top = '0%';
  }
});

// Pushing page effect
// Optional arguments
// - direction ..... Direction of movement
//     right   ... Left to Right
//     left    ... Right to Left
//     up      ... Top to Bottom
//     down    ... Bottom to Top
Libretto.registerPageEffect('push', {
  before(prevStyle, nextStyle, duration, options) {
    let posPrefix = {
      left: ['0%', '0%', '100%', '0%', '-100%', '0%', '0%', '0%'],
      right: ['0%', '0%', '-100%', '0%', '100%', '0%', '0%', '0%'],
      up: ['0%', '0%', '0%', '100%', '0%', '-100%', '0%', '0%'],
      down: ['0%', '0%', '0%', '-100%', '0%', '100%', '0%', '0%']
    };
    this.pos = posPrefix[options.direction];
    if (typeof this.pos === 'undefined') {
      if (typeof options.direction !== 'undefined') {
        console.warn('Invalid value of direction: ', options.direction);
      }
      this.pos = posPrefix['left'];
    }
    prevStyle.left = this.pos[0];
    prevStyle.top = this.pos[1];
    nextStyle.left = this.pos[2];
    nextStyle.top = this.pos[3];
  },
  exec(prevStyle, nextStyle, duration, options) {
    if (duration === null) {
      duration = '1s';
    }
    prevStyle.transitionDuration = duration;
    prevStyle.left = this.pos[4];
    prevStyle.top = this.pos[5];
    nextStyle.transitionDuration = duration;
    nextStyle.left = this.pos[6];
    nextStyle.top = this.pos[7];
  }
});

// Slide-in Page Effect
// Optional arguments
// - direction ..... Direction of zooming
//     up
//     down
//     in
//     out
Libretto.registerPageEffect('scale', {
  before(prevStyle, nextStyle, duration, options) {
    let direction = options.direction;
    this.targetNext = true;   // A target of the animation is next slide when true
    this.zoomin = true;       // Zooming is zoom-in when true
    switch (direction) {
    case 'up':
      this.targetNext = true;
      this.zoomin = true;
      break;
    case 'in':
      this.targetNext = true;
      this.zoomin = false;
      break;
    case 'out':
      this.targetNext = false;
      this.zoomin = true;
      break;
    case 'down':
      this.targetNext = false;
      this.zoomin = false;
      break;
    default:
      if (direction !== null) {
        console.warn('Invalid value of direction: ', direction);
      }
    }
    if (this.targetNext) {
      prevStyle.zIndex = '0';
      nextStyle.zIndex = '1';
      nextStyle.opacity = '0';
      if (this.zoomin) {
        nextStyle.transform = 'scale(0.2,0.2)';
        nextStyle.mozTransform = 'scale(0.2,0.2)';
        nextStyle.webkitTransform = 'scale(0.2,0.2)';
      } else {
        nextStyle.transform = 'scale(3.0,3.0)';
        nextStyle.mozTransform = 'scale(3.0,3.0)';
        nextStyle.webkitTransform = 'scale(3.0,3.0)';
      }
    } else {  // if next slide will animate
      prevStyle.zIndex = '1';
      nextStyle.zIndex = '0';
      prevStyle.opacity = '1';
      nextStyle.transform = 'scale(1,1)';
      nextStyle.mozTransform = 'scale(1,1)';
      nextStyle.webkitTransform = 'scale(1,1)';
    }
  },
  exec(prevStyle, nextStyle, duration, options) {
    if (duration === null) {
      duration = '1s';
    }
    if (this.targetNext) {
      nextStyle.transitionDuration = duration;
      nextStyle.opacity = '1';
      nextStyle.transform = 'scale(1.0,1.0)';
      nextStyle.mozTransform = 'scale(1.0,1.0)';
      nextStyle.webkitTransform = 'scale(1.0,1.0)';
    } else {
      prevStyle.transitionDuration = duration;
      prevStyle.opacity = '0';
      if (this.zoomin) {
        prevStyle.transform = 'scale(3,3)';
        prevStyle.mozTransform = 'scale(3,3)';
        prevStyle.webkitTransform = 'scale(3,3)';
      } else {
        prevStyle.transform = 'scale(0.2,0.2)';
        prevStyle.mozTransform = 'scale(0.2,0.2)';
        prevStyle.webkitTransform = 'scale(0.2,0.2)';
      }
    }
  }
});
