class Foto < ActiveRecord::Base
  
  has_attached_file :pica
  
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
end
