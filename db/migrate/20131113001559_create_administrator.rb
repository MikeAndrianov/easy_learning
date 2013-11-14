class CreateAdministrator < ActiveRecord::Migration
  
  class User < ActiveRecord::Base
    ROLES = %w[Administrator Lecturer Student]

    def roles=(roles)
      self.roles_mask = (roles & User::ROLES).map { |r| 2**User::ROLES.index(r) }.sum
    end

    def roles
      User::ROLES.reject { |r| ((roles_mask || 0) & 2**User::ROLES.index(r)).zero? }
    end
  end


  def self.up
    admin = User.new
    admin.roles = ["Administrator"]
    admin.update_attributes(:name => 'Admin', :email => 'admin@email.com') if admin
  end

  def self.down
    #
    #refactor this solution!
    user = User.where(name: 'Admin')
    user.destroy
  end
end
