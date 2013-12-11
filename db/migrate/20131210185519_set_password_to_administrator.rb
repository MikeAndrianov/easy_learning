class SetPasswordToAdministrator < ActiveRecord::Migration
  def up
    admin = ::User.find_or_create_by_email_and_name("admin@email.com", "Admin")
    admin.password = admin.password_confirmation = "easylearning"
    admin.role = "Administrator"
    admin.save!
  end
end
