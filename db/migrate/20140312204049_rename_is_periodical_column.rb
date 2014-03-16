class RenameIsPeriodicalColumn < ActiveRecord::Migration
  def change
    rename_column :events, :is_periodical, :is_recurrent
  end
end
