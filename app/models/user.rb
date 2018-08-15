class User < ApplicationRecord
  include Clearance::User
  #Enum to set role
  enum role: [:customer, :moderator, :admin]

  #avatar uploader carrierwave
  mount_uploader :avatar, AvatarUploader
  
  has_many :authentications, dependent: :destroy
  has_many :listings

  #for reservations
  has_many :reservations
 

  #Method to create object User based on info from Google
  def self.create_with_auth_and_hash(authentication, auth_hash)
  	user = self.create!(
  		first_name: auth_hash["info"]["first_name"],
  		last_name: auth_hash["info"]["last_name"],		
  		email: auth_hash["info"]["email"],
  		#placeholder birthdate (date today) so can save new user to db. 
  		birthdate: Date.new,
  		#Creating random password because db doesnt get password (user using google password)
  		password: SecureRandom.hex(10)
  	)
  	user.authentications << authentication
  	return user  	
  end

   # grab google to access google for user data
   # 
   def google_token
   	x = self.authentications.find_by(provider: 'google_oauth2')
   	return x.token unless x.nil?	
   end
end
