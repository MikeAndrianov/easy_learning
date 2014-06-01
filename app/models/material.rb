class Material < ActiveRecord::Base
  belongs_to :section

  has_attached_file :file
end
