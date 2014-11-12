class User < ActiveRecord::Base
  
  def has_password?(submitted_password, encrypted_password)
    submitted_password == encrypted_password
     #encrypted_password == encrypt(submitted_password)
   end
  
  def self.authenticate(nombre, submitted_password) 
     @user = User.find_by(nombre: nombre)
     return nil if @user.nil?
     return @user if @user.has_password?(submitted_password, @user.password)
   end
   
   def encrypt_password
     self.salt = make_salt if new_record?
     self.encrypted_password = encrypt(password)
   end

   def encrypt(string)
     secure_hash("#{salt}--#{string}")
   end

   def make_salt
     secure_hash("#{Time.now.utc}--#{password}")
   end

   def secure_hash(string)
     Digest::SHA2.hexdigest(string)
   end
   
   
end
