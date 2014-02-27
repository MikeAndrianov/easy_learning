class ChangeQuestionsBelongsToColumn < ActiveRecord::Migration
  def change
  	remove_index	:questions, :test_id
  	rename_column :questions, :test_id, :control_id
  	add_index 		:questions, :control_id
  end
end
