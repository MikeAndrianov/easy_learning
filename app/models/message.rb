class Message < ActiveRecord::Base
  has_many :message_users
  has_many :recipients, through: :message_users, source: :user
  belongs_to :sender, class_name: 'User', foreign_key: :created_by_id
end
