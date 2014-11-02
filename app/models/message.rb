class Message < ActiveRecord::Base
  has_many :message_users
  has_many :recipients, through: :message_users, source: :user
  belongs_to :sender, class_name: 'User', foreign_key: :created_by

  validates :body, presence: true

  scope :outbox, ->(user_id) { where(created_by: user_id) }
  scope :inbox, ->(user_id) { joins(:message_users).where('message_users.user_id = ?', user_id) }
end
