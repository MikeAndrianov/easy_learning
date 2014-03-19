class Control < ActiveRecord::Base
	has_many :questions,:dependent => :destroy
end
