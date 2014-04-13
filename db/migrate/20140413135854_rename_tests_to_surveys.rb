class RenameTestsToSurveys < ActiveRecord::Migration
  def change
    rename_table :tests, :surveys
  end
end
