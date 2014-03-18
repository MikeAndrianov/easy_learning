class Course < ActiveRecord::Base

	has_and_belongs_to_many :groups
	belongs_to :lecturer

end