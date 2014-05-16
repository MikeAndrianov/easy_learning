class User < ActiveRecord::Base
  has_many :participations
  has_many :events, :through => :participations
  has_many :events_created_by_me, :class_name => 'Event', :foreign_key => :created_by_id

  has_many :survey_results
  has_many :surveys, through: :survey_results
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Devise checks presence of email field. We shouldn't do it here one more time. 
  #
  validates :name, presence: true

  validates_format_of :email,
    :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z]{2,4}$/i, :multiline => true, 
      :message => "must be in example@email.com format."
  
  validates_format_of :mobile,
    :with => /\+([\d]){3}[-" "]*([\d]){2}[-" "]*([\d]){7}$/i, :multiline => true ,
      :message => "number must be in +375-xx-xxxxxxx format.", :allow_blank => true


  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = ["Administrator", "Lecturer", "Student"]

  def shared_events
    Event.shared_for(self)
  end

  def events_created_for_me
    events.where('created_by_id != ?', self.id)
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def admin?
    type == "Admin"
  end

  def lecturer?
    type == "Lecturer"
  end

  def student?
    type == "Student"
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  #
  #As for now we have one Role per User. It's not quite good to do. 
  #This HOTFIX must be refactoried!
  
  #def role
  #  roles.last
  #end

end
