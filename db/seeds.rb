# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# admin create
@user=User.create(email: 'admin@mail.com',type: 'Admin',password: '12345678',name: 'admin')
# student create
User.create(email: 'student@mail.com',type: 'Student',password: '12345678',name: 'student')

# here we create 3 stub subjects with surveys
3.times do |z|
  Subject.create(name: "Subject #{z+1}").tap do |subject|
    3.times do |i|
      # create 3 survey
      survey=subject.surveys.create(name: "Survey #{z*3+i+1}").tap do |survey|
    	  3.times do |j|
    		  survey.questions.create(content:"Question #{j+1}").tap do |question|
    			  3.times do |k|
    				  question.answers.create(content: "Answer #{k+1+j*3}")
    			  end
    		  end
          # add 3 random results to current survey
          survey.survey_results.create(user: @user, right_answered: Random.new.rand(1..3), total: 3)
    	  end        
      end
      # create 3 sections
      subject.sections.create(name: "Section #{i}")      
    end    
  end
end
