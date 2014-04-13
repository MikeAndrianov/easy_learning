class RenameTestIdFkColumn < ActiveRecord::Migration
  def change
    rename_column :questions, :test_id, :survey_id
  end
end
