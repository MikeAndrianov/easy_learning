class AddIsPeriodicalToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_periodical, :boolean
  end
end
