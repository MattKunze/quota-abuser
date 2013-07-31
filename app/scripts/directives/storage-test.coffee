'use strict';

angular.module('quotaAbuserApp')
  .directive('storageTest', () ->
    templateUrl: 'partials/storage-test.html'
    restrict: 'E'
    scope:
      key: '@key'
    controller: [ '$scope', '$element', '$attrs', 'testFactory',
      ($scope, $element, $attrs, testFactory) ->
        test = testFactory.get $attrs.key
        $scope.details =
          test: test
          icon: if test.available() then 'icon-thumbs-up-alt' else 'icon-frown'

        apply = (cb) ->
          phase = $scope.$root.$$phase;
          if phase in [ '$apply', '$digest' ]
            cb()
          else
            $scope.$apply cb

        $scope.available = -> test.available()

        testPromise = null
        $scope.isRunning = -> testPromise?

        $scope.runTest = ->
          options =
            step: ($element.find '.test-step').val()
            halt: ($element.find '.test-halt').val()
          isRunning = true
          testPromise = testFactory.run test, options
          $.when(testPromise)
            .progress( (status) ->
              apply -> $scope.details.status = status
            )
            .fail( (status) ->
              apply -> $scope.details.status = status
            )
            .always -> 
              apply -> testPromise = null

        $scope.cancelTest = ->
          testPromise?.cancel()
    ]
  )
