'use strict'

describe 'Service: testFactory', () ->

  # load the service's module
  beforeEach module 'quotaAbuserApp'

  # instantiate service
  testFactory = {}
  beforeEach inject (_testFactory_) ->
    testFactory = _testFactory_

  it 'should do something', () ->
    expect(!!testFactory).toBe true;
