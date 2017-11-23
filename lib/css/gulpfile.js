var gulp = require('gulp'),
  sass = require('gulp-ruby-sass');

gulp.task('sass', function () {
  return sass('sass/*.scss').pipe(gulp.dest(''));
});

gulp.task('watch', function () {
  gulp.watch(['sass/*/**.scss'], ['sass']);
});
