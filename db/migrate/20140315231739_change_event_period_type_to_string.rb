class ChangeEventPeriodTypeToString < ActiveRecord::Migration
  def up
    change_column :events, :period, :string
  end

  def down
    change_column :events, :period, :datetime
  end
end
