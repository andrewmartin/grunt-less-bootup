'use strict'
module.exports = (grunt) ->
  path = require('path')

  # load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  require('time-grunt')(grunt)
  # config
  grunt.initConfig

    watch:
      options:
        livereload: false
        spawn: false

      less:
        files: ['src/stylesheets/**/*.less']
        tasks: ['less']

      coffee:
        files: ['src/scripts/**/*.coffee']
        tasks: ['coffee']

    less:
      dashboard:
        files:
          'dist/css/application.css': 'src/stylesheets/application.less'
        options:
          cleancss: true
          sourceMap: true

    coffee:
      dev:
        options:
          sourceMap: true
        expand: true
        cwd: 'src/scripts'
        src: '**/*.coffee'
        dest: 'dist/scripts'
        ext: '.js'

# minification and beautification tasks

    # minify and compress css

    cssmin:
      options:
        report: 'min'
        banner: '/* minified via grunt task. Check Gruntfile.coffee for more info. */'
      app:
        files: 'dist/css/application.min.css': 'dist/css/application.css'

  grunt.registerTask('default', ['coffee', 'less', 'watch'])
  grunt.registerTask('build', ['less', 'cssmin'])