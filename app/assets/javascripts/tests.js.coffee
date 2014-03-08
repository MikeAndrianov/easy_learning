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
          id: data
          content: $scope.formQuestionText
          answers: []
        )
        $scope.formQuestionText = ""
        return

    return

  $scope.deleteQuestion = (question)  ->
    $http(
      method: 'POST'
      url: '/test/edit/question/delete'
      headers: 'Content-Type': 'application/json'
      data: question.id
    ).success((data)->
      $scope.test.questions.splice($scope.test.questions.indexOf(question), 1)
    )

  $scope.addAnswer = (question, formAnswerText) ->
    newAnswer =
      content: formAnswerText
      questionId: question.id
      isRight: false

    $http(
      method: "POST"
      url: "/test/edit/answer/add"
      headers: "Content-Type": "application/json"
      data: newAnswer
    ).success (data) ->
      question.answers.push
        id: data
        content: formAnswerText
        questionId: question.id
        isRight: false

      formAnswerText = ""
      return

    return 

  $scope.deleteAnswer = (question, answer) ->
    $http(
      method: "POST"
      url: "/test/edit/answer/delete"
      headers: "Content-Type": "application/json"
      data: answer.id
    ).success (data) ->
      question.answers.splice question.answers.indexOf(answer), 1
      return

    return   
)