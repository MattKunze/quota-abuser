'use strict';

angular.module('quotaAbuserApp')
  .factory 'localStorageTester', () ->

    key: 'localStorage'
    title: 'Local Storage'
    available: -> window.localStorage?
    runTest: (options) ->
      promise = new $.Deferred

      localStorage.clear()

      count = 0
      _insertChunk = (cb) =>
        try
          localStorage.setItem(count++, @oneK)
          promise.notify "Stored: #{count}KB"
          cb() if cb
          true
        catch error
          promise.reject "Max: #{count}KB - #{error.message}"

      next = -> _.defer _insertChunk, next
      next()

      promise.promise()

