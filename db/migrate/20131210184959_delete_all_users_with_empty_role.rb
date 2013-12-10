class DeleteAllUsersWithEmptyRole < ActiveRecord::Migration
  def up
    execute <<-SQL
      DELETE users.* FROM users WHERE `users`.`role` IS NULL;
    SQL
  end
end
