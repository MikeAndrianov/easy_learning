class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.references :subject, index: true

      t.timestamps
    end
  end
end
