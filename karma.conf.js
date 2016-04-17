module.exports = function(config) {
  var options = {
    basePath: '',
    frameworks: ['browserify', 'mocha', 'chai'],
    files: [
      'build/libretto.js',
      'spec/*_spec.js'
    ],
    exclude: [
    ],
    preprocessors: {
      'spec/*_spec.js': [ 'browserify' ]
    },
    browserify: {
      debug: true,
      transform: [ 'babelify' ]
    },
    reporters: ['dots'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: false,
    browsers: ['Firefox'],
    singleRun: true,
    concurrency: Infinity
  };
  if (process.env.TRAVIS) {
    options.customLaunchers = {
      chrome_travis_ci: {
        base: 'Chrome',
        flags: ['--no-sandbox']
      }
    };
    options.browsers.push('chrome_travis_ci');
  } else {
    options.browsers.push('Chrome');
  }
  config.set(options);
};
