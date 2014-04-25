class Subject < ActiveRecord::Base
	has_many :surveys,:dependent => :destroy
end
