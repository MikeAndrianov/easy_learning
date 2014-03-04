# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@testEditApp = angular.module("testEditApp", ['ng-rails-csrf'])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['testEditApp'])
  )


testEditApp.controller('TestCtrl', ($scope,$http)->
  $http.get('/test/edit/getTest')
  .then( (res)-> 
    $scope.test = res.data
    )

  $scope.addQuestion = ->
    newQuestion =
      content: $scope.formQuestionText
      test_id: $scope.test.id

    $http(
      method: "POST"
      url: "/test/edit/question/add"
      headers: "Content-Type": "application/json"
      data: newQuestion
      ).success (data) ->
        $scope.test.questions.unshift(
          id: data.id
          content: $scope.formQuestionText
          answers: []
        )    
        $scope.formQuestionText = ""
        return

        return
        )


# @TestEdit.controller 'TestCtrl', ['$scope', '$http', '$routeParams'], ($scope, $http, $routeParams) ->
#     $scope.test=$routeParams;
#   )

