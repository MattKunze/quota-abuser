'use strict';

angular.module('quotaAbuserApp')
  .factory 'testFactory', [ 'localStorageTester', 'webSqlTester'
    (lsTester, wsTester) ->
      tests = {}

      chunk = '0123456789abcdef'
      oneK = (_.collect [0...64], -> chunk).join ''
      oneM = (_.collect [0...1024], -> oneK).join ''

      for test in [ lsTester, wsTester ]
        tests[test.key] = test

        # ugh - figure out circular dependencies
        _.extend test, { oneK, oneM}

      get: (key) ->
        tests[key]

      chunk: (size) ->
        switch size
          when 'k' then oneK
          when 'm' then oneM
          else chunk
  ]

