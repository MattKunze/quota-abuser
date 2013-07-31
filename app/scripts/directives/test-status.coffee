'use strict';

angular.module('quotaAbuserApp')
  .directive('testStatus', () ->
    templateUrl: 'partials/test-status.html'
    restrict: 'E'
    controller: [ '$scope', '$element', '$attrs', 'testFactory',
      ($scope, $element, $attrs, testFactory) ->
    ]
  )
