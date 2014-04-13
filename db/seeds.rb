# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# here we create 2 stub surveys
2.times do |i|
  Survey.create(name: "Survey #{i+1}").tap do |survey|
  	3.times do |j|
  		survey.questions.create(content:"Question #{j+1}").tap do |question|
  			3.times do |k|
  				question.answers.create(content: "Answer #{k+1+j*3}")
  			end
  		end
  	end
  end
end
# admin create
User.create(email: 'admin@mail.com',role: 'Administrator',password: '12345678',name: 'admin')
# student create
User.create(email: 'student@mail.com',role: 'Student',password: '12345678',name: 'student')