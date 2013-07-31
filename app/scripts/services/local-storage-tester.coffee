'use strict';

angular.module('quotaAbuserApp')
  .factory 'localStorageTester', () ->

    key: 'localStorage'
    title: 'Local Storage'
    available: -> window.localStorage?
    defaults:
      step: '1k'
    reset: (options) ->
      localStorage.clear()
    next: (options) ->
      localStorage.setItem options.offset, options.chunk
      options.success()
