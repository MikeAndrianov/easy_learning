class Survey < ActiveRecord::Base
	has_many :questions,:dependent => :destroy
	belongs_to :subject
	accepts_nested_attributes_for :questions

  has_many :survey_results
  has_many :users, through: :survey_results
end
