class AddIsRightToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :is_right, :boolean
  end
end
