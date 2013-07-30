'use strict';

angular.module('quotaAbuserApp')
  .directive('storageTest', () ->
    templateUrl: 'partials/storage-test.html'
    restrict: 'E'
    scope:
      key: '@key'
    controller: [ '$scope', '$element', '$attrs', 'testFactory',
      ($scope, $element, $attrs, testFactory) ->
        $scope.test = testFactory.get $attrs.key

        $scope.icon = if $scope.test.available()
          'icon-thumbs-up-alt'
        else
          'icon-frown'

        $scope.progress = 'Waiting'

        $scope.runTest = ->
          $.when($scope.test.runTest())
            .progress( (details) ->
              $scope.$apply ->
                $scope.progress = details
            )
            .fail (error) ->
              $scope.$apply ->
                $scope.progress = error
    ]
    link: (scope, element, attrs) ->
      element.bind 'click', ->
        return false unless scope.test.available()
  )
