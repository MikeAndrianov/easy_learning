class Survey < ActiveRecord::Base
	has_many :questions,:dependent => :destroy
	belongs_to :subject
end
