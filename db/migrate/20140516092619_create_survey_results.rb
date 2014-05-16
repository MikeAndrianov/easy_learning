class CreateSurveyResults < ActiveRecord::Migration
  def change
    create_table :survey_results do |t|
      t.references :survey, index: true
      t.references :user, index: true
      t.integer :right_answered
      t.integer :total

      t.timestamps
    end
  end
end
