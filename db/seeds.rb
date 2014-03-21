# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# here we create 2 stub tests 
2.times do |i|
  Control.create(name: "Test #{i+1}").tap do |control|
  	3.times do |j|
  		control.questions.create(content:"Question #{j+1}").tap do |question|
  			3.times do |k|
  				question.answers.create(content: "Answer #{k+1+j*3}")
  			end
  		end
  	end
  end
end
# admin create
User.create(email: 'admin@mail.com',type: 'Admin',password: '12345678',name: 'admin')
# student create
User.create(email: 'student@mail.com',type: 'Student',password: '12345678',name: 'student')

Group.create(number: 1)
Group.create(number: 2)
20.times do
  Student.create(email: Faker::Internet.free_email, name: Faker::Name.name, password: 'password', 
    group: Group.find_by(number: 1))
  Student.create(email: Faker::Internet.free_email, name: Faker::Name.name, password: 'password', 
    group: Group.find_by(number: 2))
end
lecturer=[]
2.times do |i|
  lecturer[i]=Lecturer.create(email: Faker::Internet.free_email, name: Faker::Name.name, password: 'password')
end
5.times do
  Group.find_by(number: 1).courses << (Course.create(name: Faker::Lorem.word, 
    lecturer: lecturer[rand(2)]))
  Group.find_by(number: 2).courses << (Course.create(name: Faker::Lorem.word,
    lecturer: lecturer[rand(2)]))
end