class User < ActiveRecord::Base
  has_many  :destinations
  has_secure_password
  
  validates :username, presence: true,
                       uniqueness: true
  validates :email, presence: true,
                    uniqueness: true
                      #  format: {:with
  # validates :password, presence: true
end