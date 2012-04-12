class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  
  has_many :leagues, :foreign_key => "commissioner_id"
end
