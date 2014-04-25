class AddSubjectIdToSurveys < ActiveRecord::Migration
  def change
  	add_column :surveys, :subject_id, :integer
    add_index  :surveys, :subject_id
  end
end
