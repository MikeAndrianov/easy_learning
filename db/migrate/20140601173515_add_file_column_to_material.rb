class AddFileColumnToMaterial < ActiveRecord::Migration
  def self.up
    add_attachment :materials, :file
  end

  def self.down
    remove_attachment :materials, :file
  end
end
