var gulp = require('gulp');
var sass = require('gulp-sass');

gulp.task('build', function() {
  var coffee = require('gulp-coffee');
  var concat = require('gulp-concat');
  var buildSrc = gulp.src(['src/index.coffee', 'src/**/*.coffee'])
  .pipe(coffee({ bare: true,
                 join: true}))
  .pipe(concat('libretto.js'))
  .pipe(gulp.dest('build'));

  var buildSpec = gulp.src('spec/**/*_spec.coffee')
  .pipe(coffee({ bare: true,
                 join: true}))
  .pipe(concat('spec.js'))
  .pipe(gulp.dest('build'));

  var buildCss = gulp.src('css/**/*.{sass,scss}')
  .pipe(sass().on('error', sass.logError))
  .pipe(gulp.dest('build'));

  return [buildSrc, buildSpec, buildCss];
});

gulp.task('gh-pages', function() {
  var coffee = require('gulp-coffee');
  var copyRaw = gulp.src('gh-pages/**/*.{html,svg,png}', { base: 'gh-pages' })
  .pipe(gulp.dest('build'));
  var buildCoffee = gulp.src('gh-pages/index.coffee')
  .pipe(coffee({ bare: true, join: true}))
  .pipe(gulp.dest('build'));
  var buildCss = gulp.src('gh-pages/index.sass')
  .pipe(sass().on('error', sass.logError))
  .pipe(gulp.dest('build'));
  return [copyRaw, buildCoffee, buildCss];
});
