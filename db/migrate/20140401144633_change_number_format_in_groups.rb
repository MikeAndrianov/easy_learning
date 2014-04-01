class ChangeNumberFormatInGroups < ActiveRecord::Migration
  def up
    change_column :groups, :number, :string
  end

  def down
   change_column :groups, :number, :integer
  end
end
