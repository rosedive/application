class User < ApplicationRecord
  has_secure_password
  #attr_accessible :email, :name, :user_type, :password, :password_confirmation
  
  validates_uniqueness_of :email
  #has_many :tasks
end
