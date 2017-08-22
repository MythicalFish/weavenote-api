var gulp = require('gulp'),
  sass = require('gulp-ruby-sass');

gulp.task('sass', function () {
  return sass('style.scss')
    .pipe(gulp.dest(''));

});

gulp.task('watch', function () {
  gulp.watch(['*.scss'], ['sass']);
});
