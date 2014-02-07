class Answer < ActiveRecord::Base
	belongs_to :question	
	attr_accessor :is_checked	
end
