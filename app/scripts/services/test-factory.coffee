'use strict';

angular.module('quotaAbuserApp')
  .factory 'testFactory', [ 'localStorageTester', 'webSqlTester'
    (lsTester, wsTester) ->
      tests = {}

      chunk = '0123456789abcdef'
      _1k = (_.collect [0...64], -> chunk).join ''
      _1m = (_.collect [0...1024], -> _1k).join ''

      for test in [ lsTester, wsTester ]
        tests[test.key] = test

      get: (key) -> tests[key]

      run: (test, options) ->
        promise = new $.Deferred

        start = new Date
        status =
          status: 'Resetting'
          elapsed: '0s'
          size: ''
        promise.notify status
        test.reset options

        notify = _.throttle ( (status) ->
          promise.notify status
        ), 100

        cancelled = false
        chunk = _1k
        offset = 0
        size = 1
        suffix = 'k'
        doNext = =>
          if cancelled
            promise.reject _.extend status,
              status: 'Cancelled'
              elapsed: @getElapsed start
            return

          try
            test.next
              offset: offset++
              chunk: chunk
              success: =>
                notify _.extend status,
                  status: 'Running'
                  size: (offset * size) + suffix
                  elapsed: @getElapsed start
                _.defer doNext

              error: (error) =>
                promise.reject _.extend status,
                  status: 'Error'
                  message: error
                  elapsed: @getElapsed start

          catch error
            promise.reject _.extend status,
              status: 'Error'
              message: error.message
              elapsed: @getElapsed start

        doNext()

        _.extend promise.promise(), cancel: -> cancelled = true

      getElapsed: (start) ->
        delta = (new Date) - start
        if delta > 1000
          delta /= 1000
          "#{delta.toFixed 2}s"
        else
          "#{delta}ms"
  ]

