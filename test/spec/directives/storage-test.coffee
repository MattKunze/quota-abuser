'use strict'

describe 'Directive: storageTest', () ->
  beforeEach module 'quotaAbuserApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<storage-test></storage-test>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the storageTest directive'
