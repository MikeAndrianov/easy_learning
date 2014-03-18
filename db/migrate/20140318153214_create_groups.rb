class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :number
      t.timestamps
    end
    create_table :courses_groups, id: false do |t|
      t.integer :course_id
      t.integer :group_id
      t.timestamps
    end
    create_table :courses do |t|
    	t.string :name
      t.integer :lecturer_id
      t.timestamps
    end
    add_column :users, :group_id, :integer
  end
end
