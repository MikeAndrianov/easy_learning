class ChangeStartsAtFormatInEvents < ActiveRecord::Migration
  def up
    change_column :events, :starts_at, :datetime
  end

  def down
    change_column :events, :starts_at, :date
  end
end
