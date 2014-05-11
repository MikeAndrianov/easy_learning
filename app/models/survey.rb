class Survey < ActiveRecord::Base
	has_many :questions,:dependent => :destroy
	belongs_to :subject
	accepts_nested_attributes_for :questions
end
