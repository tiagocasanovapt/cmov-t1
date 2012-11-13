class User < ActiveRecord::Base
  has_one :credit, :dependent => :destroy
  has_many :reservations

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable, :encryptable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :authentication_token, :credit_attributes 
  accepts_nested_attributes_for :credit  

  

  validates :name, :presence => true, :length => { :minimum => 2 }


end
