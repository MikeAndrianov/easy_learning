class Question < ActiveRecord::Base
	belongs_to :control
	has_many :answers,:dependent => :destroy
end
