class RenameTestTable < ActiveRecord::Migration
  def change
  	rename_table :tests, :controls
  end
end
