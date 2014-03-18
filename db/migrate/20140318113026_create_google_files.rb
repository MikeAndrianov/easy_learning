class CreateGoogleFiles < ActiveRecord::Migration
  def change
    create_table :google_files do |t|
      t.string :name
      t.string :google_id

      t.timestamps
    end
    add_column :users, :google_refresh_token, :string
    add_column :users, :google_expires_at, :string
  end
end
