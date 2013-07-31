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
          console.warn "phase: #{phase}"
          if phase in [ '$apply', '$digest' ]
            cb()
          else
            $scope.$apply cb

        $scope.available = -> test.available()
        $scope.runTest = ->
          options =
            step: ($element.find '.test-step').val()
            halt: ($element.find '.test-halt').val()
          $.when(testFactory.run test, options)
            .progress( (status) ->
              console.warn status
              apply -> $scope.details.status = status
            )
            .fail (status) ->
              apply -> $scope.details.status = status
    ]
  )
