class AddPeriodToEvents < ActiveRecord::Migration
  def change
    add_column :events, :period, :datetime
  end
end
