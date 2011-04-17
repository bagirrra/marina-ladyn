class Admin < ActiveRecord::Base
  validates_presence_of :login
  validates_uniqueness_of :login
  validates_presence_of :password
  validates_confirmation_of :password

  # Include default devise modules. 
  devise :database_authenticatable
  # Setup accessible (or protected) attributes for your model 
  attr_accessible :login, :password, :password_confirmation 
end
