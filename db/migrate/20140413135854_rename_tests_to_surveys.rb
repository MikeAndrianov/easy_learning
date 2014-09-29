class RenameTestsToSurveys < ActiveRecord::Migration
  def change
    rename_table :controls, :surveys
  end
end
