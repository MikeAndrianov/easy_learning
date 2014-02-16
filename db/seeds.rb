# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
2.times do |i|
  Test.create(name: "Test #{i+1}").tap do |test|
  	3.times do |j|
  		test.questions.create(content:"Question #{j+1}").tap do |question|
  			3.times do |k|
  				question.answers.create(content: "Answer #{k+1+j*3}")
  			end
  		end
  	end
  end
end
