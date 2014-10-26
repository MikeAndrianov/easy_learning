class Message < ActiveRecord::Base
  has_many :message_users
  has_many :users, through: :message_users
end
