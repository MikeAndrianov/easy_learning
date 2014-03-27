class AddCreatedByIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :created_by_id, :integer, :default => 1
  end
end
