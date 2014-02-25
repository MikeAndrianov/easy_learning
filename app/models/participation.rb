class Participation < ActiveRecord::Base
  belongs_to :user
  #belongs_to :participant_id, :class_name => "User"
  belongs_to :event
end
