'use strict'

describe 'Directive: localStorageTest', () ->
  beforeEach module 'quotaAbuserApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<local-storage-test></local-storage-test>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the localStorageTest directive'
