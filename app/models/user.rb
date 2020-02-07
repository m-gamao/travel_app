class User < ActiveRecord::Base
  has_many  :destinations
  has_secure_password
  
  #at @user.save, the user data is checked for the below before saving to the db.
  validates :username, presence: true,
                       uniqueness: true
  validates :email, presence: true,
                    uniqueness: true

end