var gulp = require('gulp');
var babel = require('gulp-babel');
var sass = require('gulp-sass');
var eslint = require('gulp-eslint');

gulp.task('gh-pages', function() {
  var copyRaw = gulp.src('gh-pages/**/*.{html,svg,png}', { base: 'gh-pages' })
  .pipe(gulp.dest('build'));
  var buildCoffee = gulp.src('gh-pages/index.js')
  .pipe(babel({ presets: ["es2015"] }))
  .pipe(gulp.dest('build'));
  var buildCss = gulp.src('gh-pages/index.sass')
  .pipe(sass().on('error', sass.logError))
  .pipe(gulp.dest('build'));
  return [copyRaw, buildCoffee, buildCss];
});

gulp.task('build', function() {
  var concat = require('gulp-concat');
  var buildSrc = gulp.src(['src/index.js', 'src/**/*.js'])
  .pipe(babel({ presets: ["es2015"] }))
  .pipe(concat('libretto.js'))
  .pipe(gulp.dest('build'));

  var buildSpec = gulp.src('spec/**/*_spec.js')
  .pipe(babel({ presets: ["es2015"] }))
  .pipe(concat('spec.js'))
  .pipe(gulp.dest('build'));

  var buildCss = gulp.src('css/**/*.{sass,scss}')
  .pipe(sass().on('error', sass.logError))
  .pipe(gulp.dest('build'));

  return [buildSrc, buildSpec, buildCss];
});

gulp.task('lint', function () {
  return gulp.src(['src/**/*.js'])
  .pipe(eslint())
  .pipe(eslint.format())
  .pipe(eslint.failAfterError());
});

gulp.task('default', ['lint', 'build']);
