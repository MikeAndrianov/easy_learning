class AddIndexToQuestionsAndAnswers < ActiveRecord::Migration
  def change
  	add_index :answers, :question_id
  	add_index :questions, :test_id
  end
end
