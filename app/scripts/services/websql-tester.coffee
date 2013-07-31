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
      errorHandler = (error) -> options.error? error
      successHandler = -> options.success?()

      _db.transaction executor, errorHandler, successHandler

    _insertSql = 'insert into stuff (key, chunk) values ( ?, ? )'

    key: 'webSql'
    title: 'Web SQL'
    available: -> window.openDatabase?
    defaults:
      step: '10k'
      halt: '10m'
    reset: (options) ->
      sql = 'create table if not exists stuff (key int, chunk text)'
      _doTx sql
    next: (options) ->
      _doTx _insertSql,
        _.extend parameters: [options.offset, options.chunk], options

