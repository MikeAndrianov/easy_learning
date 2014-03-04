# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@controlEditApp = angular.module("controlEditApp", ['ng-rails-csrf'])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['controlEditApp'])
  )


controlEditApp.controller('ControlCtrl', ($scope,$http)->
  $http.get('/test/edit/getTest')
  .then( (res)-> 
    $scope.test = res.data
    )

  $scope.addQuestion = ->
    newQuestion =
      content: $scope.formQuestionText
      control_id: $scope.test.id

    $http(
      method: "POST"
      url: "/test/edit/question/add"
      headers: "Content-Type": "application/json"
      data: newQuestion
      ).success (data) ->
        $scope.control.questions.unshift(
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

