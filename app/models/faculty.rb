class Faculty < ActiveRecord::Base
	validates :name, :subdomain, :uniqueness => true
	validates :name, :subdomain, :presence => true
end