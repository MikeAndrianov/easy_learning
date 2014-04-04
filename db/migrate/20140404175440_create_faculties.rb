class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
    	t.string :name
    	t.string :subdomain
    	t.timestamps
    end
  end
end
