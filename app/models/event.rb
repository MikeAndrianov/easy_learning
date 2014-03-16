class Event < ActiveRecord::Base

  PERIOD = {
    "daily" => "day",
    "weekly" => "week",
    "monthly" => "month"
  }

  CREATED_BY_FILTER = {
    "All Events" => "All Events", 
    "Created By Me" => "Created By Me", 
    "Created For Me" => "Created For Me"
  }

  has_many :participations, :dependent => :destroy
  has_many :users, :through => :participations, :validate => false

  validates :name, :starts_at, :presence => true
  validates :period, :presence => true, :if => "is_recurrent" 
  validate :end_date_should_be_after_start_date


  #
  #TODO: add Past Events, Future Events scopes. Show on the schedule in current and future events.
  

  scope :shared_for, lambda{ |user|
    includes("participations").where("created_by_id = ? OR participations.user_id = ?", user.id, user.id)
  }

  def occurs_on?(date = Date.today)
    if self.is_recurrent
      date_range = []
      date = self.starts_at.to_date
      
      while date <= self.ends_at.to_date do 
        date_range << date
        date += 1.send(self.period)
      end

      date_range.include?(date)
    else
      self.starts_at == date
    end
  end


  protected

  def end_date_should_be_after_start_date
    errors.add(:ends_at, "End date should be after start date") if self.is_recurrent && (self.ends_at < self.starts_at)
  end

end
