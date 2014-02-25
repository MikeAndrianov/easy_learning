class Event < ActiveRecord::Base
  has_many :participations
  has_many :users, :through => :participations, :validate => false

  validates :name, :starts_at, :presence => true


  #
  #TODO: add Past Events, Future Events scopes. Show on the schedule in current and future events.


  #
  #TODO: add creator to event
  def created_by?(user = current_user)

  end

end
