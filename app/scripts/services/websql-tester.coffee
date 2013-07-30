'use strict';

angular.module('quotaAbuserApp')
  .service 'webSqlTester', () ->

    if window.openDatabase
      _db = window.openDatabase 'QuotaAbuser'
      , '0.0'
      , 'Storage quota test application'
      , 5 * 1024 * 1024
    _doTx = (sql, options) ->
      options or= {}

      executor = (tx) ->
        tx.executeSql sql, options.parameters
      errorHandler = (error) ->
        console.warn 'tx error ' + error
      successHandler = ->
        options.callback?()

      _db.transaction executor, errorHandler, successHandler

    key: 'webSql'
    title: 'Web SQL'
    available: -> window.openDatabase?
    reset: ->
      console.warn _db

      sql = 'create table if not exists stuff (key int, chunk text)'
      _doTx sql

    runTest: (options) ->
      promise = new $.Deferred

      @reset()

      sql = 'insert into stuff (key, chunk) values ( ?, ? )'
      count = 0
      _insertChunk = (cb) =>
        try
          _doTx sql,
            parameters: [count, @oneK]
            callback: ->
              promise.notify "Stored: #{count}KB"
              cb() if cb

        catch error
          promise.reject "Max: #{count}KB - #{error.message}"

      next = -> _.defer _insertChunk, next
      next()

      promise.promise()
