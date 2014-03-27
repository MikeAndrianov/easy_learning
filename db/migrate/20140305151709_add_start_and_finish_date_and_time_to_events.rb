class AddStartAndFinishDateAndTimeToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.date :start_date
      t.time :start_time


      t.date :finish_date
      t.time :finish_time
    end
  end
end
