class RemoveStartAndFinishDateAndTimeFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :start_date, :date
    remove_column :events, :start_time, :time
    remove_column :events, :finish_time, :time
    remove_column :events, :finish_date, :date
  end
end
