# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@surveyEditApp = angular.module("surveyEditApp", ['ng-rails-csrf'])

$(document).on('ready page:load', ->
  angular.bootstrap(document, ['surveyEditApp'])
  )


surveyEditApp.controller('SurveyCtrl', ($scope,$http)->
  $http.get('/survey/edit/getSurvey')
  .then( (res)-> 
    $scope.survey = res.data
    )

  $scope.addQuestion = ->
    newQuestion =
      content: $scope.formQuestionText
      survey_id: $scope.survey.id

    $http(
      method: "POST"
      url: "/survey/edit/question/add"
      headers: "Content-Type": "application/json"
      data: newQuestion
      ).success (data) ->
        $scope.survey.questions.unshift(
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
      url: '/survey/edit/question/delete'
      headers: 'Content-Type': 'application/json'
      data: question.id
    ).success((data)->
      $scope.survey.questions.splice($scope.survey.questions.indexOf(question), 1)
    )

  $scope.addAnswer = (question, formAnswerText) ->
    newAnswer =
      content: formAnswerText
      questionId: question.id
      isRight: false

    $http(
      method: "POST"
      url: "/survey/edit/answer/add"
      headers: "Content-Type": "application/json"
      data: newAnswer
    ).success (data) ->
      question.answers.push
        id: data
        content: formAnswerText
        questionId: question.id
        is_right: false

      formAnswerText = ""
      return

    return 

  $scope.deleteAnswer = (question, answer) ->
    $http(
      method: "POST"
      url: "/survey/edit/answer/delete"
      headers: "Content-Type": "application/json"
      data: answer.id
    ).success (data) ->
      question.answers.splice question.answers.indexOf(answer), 1
      return

    return

  $scope.triggerIsRight = (answer) ->
    $http(
      method: "POST"
      url: "/survey/edit/answer/triggerIsRight"
      headers: "Content-Type": "application/json"
      data: answer.id
    ).success (data) ->
      return

    return     
)