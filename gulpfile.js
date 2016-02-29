var gulp = require('gulp');

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
  return [buildSrc, buildSpec];
});
