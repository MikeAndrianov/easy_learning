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

  # Generates methods: start_time_string, finish_time_string
  #
  [:start_time, :finish_time].each do |field_name|
    define_method("#{field_name}_string") do
      self.send(field_name).strftime('%H:%M') if self.send(field_name)
    end
  end

  # [:start_time, :finish_time].each do |field_name|
  #   define_method("#{field_name}_string=") do |time|
  #     self.send("#{field_name}_string=",time.strftime('%H:%M'))
  #   end
  # end

end
