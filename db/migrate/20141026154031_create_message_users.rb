class CreateMessageUsers < ActiveRecord::Migration
  def change
    create_table :message_users do |t|
      t.references :user
      t.references :message
      t.timestamps
    end
  end
end
