'use strict'

describe 'Service: websqlTester', () ->

  # load the service's module
  beforeEach module 'quotaAbuserApp'

  # instantiate service
  websqlTester = {}
  beforeEach inject (_websqlTester_) ->
    websqlTester = _websqlTester_

  it 'should do something', () ->
    expect(!!websqlTester).toBe true;
