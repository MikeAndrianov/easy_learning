class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.belongs_to :test
      t.timestamps
    end
  end
end
