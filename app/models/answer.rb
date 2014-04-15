class Answer < ActiveRecord::Base
	belongs_to :question	
	attr_accessor :is_checked	

  after_initialize :default_values

  private
    def default_values
      self.is_right ||= false
    end
end
