'use strict'

describe 'Directive: testStatus', () ->
  beforeEach module 'quotaAbuserApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<test-status></test-status>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the testStatus directive'
