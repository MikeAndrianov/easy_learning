class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
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

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def admin?
    role == "Administrator"
  end

  def lecturer?
    role == "Lecturer"
  end

  def student? 
    role == "Student"
  end

  #
  #As for now we have one Role per User. It's not quite good to do. 
  #This HOTFIX must be refactoried!
  
  #def role
  #  roles.last
  #end

end
