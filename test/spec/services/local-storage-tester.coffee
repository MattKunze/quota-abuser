'use strict'

describe 'Service: localStorageTester', () ->

  # load the service's module
  beforeEach module 'quotaAbuserApp'

  # instantiate service
  localStorageTester = {}
  beforeEach inject (_localStorageTester_) ->
    localStorageTester = _localStorageTester_

  it 'should do something', () ->
    expect(!!localStorageTester).toBe true;
