class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :created_by_id, index: true
      t.text :body

      t.timestamps
    end
  end
end
