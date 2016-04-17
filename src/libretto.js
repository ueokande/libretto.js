// To support ES6 classes
require('babel-polyfill');

import Viewer from './viewer';
import * as PageEffect from './page_effect';
import Plugin from './plugin';

let viewerInstance = new Viewer();
window.Libretto = {
  registerPageEffect: PageEffect.registerPageEffect,
  loadPageEffect: PageEffect.loadPageEffect,
  Plugin,
  viewer: () => viewerInstance
};

// Load plugins
require('./plugins/2d-animations');
require('./plugins/auto_zoom.js');
require('./plugins/io.js');
require('./plugins/location.js');
