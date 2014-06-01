class Section < ActiveRecord::Base
  belongs_to :subject
  has_many :materials,:dependent => :destroy
end
