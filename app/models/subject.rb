class Subject < ActiveRecord::Base
	has_many :surveys,:dependent => :destroy
  has_many :sections,:dependent => :destroy
end
