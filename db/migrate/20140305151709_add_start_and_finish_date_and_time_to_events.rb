class AddStartAndFinishDateAndTimeToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.date :start_date
      t.timestamp :start_time


      t.date :finish_date
      t.timestamp :finish_time
    end
  end
end
