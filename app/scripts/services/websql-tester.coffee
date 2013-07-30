'use strict';

angular.module('quotaAbuserApp')
  .service 'webSqlTester', () ->
    key: 'webSql'
    title: 'Web SQL'
    available: -> false and window.openDatabase

