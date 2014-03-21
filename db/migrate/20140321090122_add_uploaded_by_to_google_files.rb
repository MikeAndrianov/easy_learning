class AddUploadedByToGoogleFiles < ActiveRecord::Migration
  def change
  	add_column :google_files, :uploaded_by, :string
  end
end
