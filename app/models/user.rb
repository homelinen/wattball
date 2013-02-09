class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :first_name, :last_name, :admin

  before_save :default_values

  has_one :team
  has_one :athlete
  has_one :official

  def default_values
      self.admin = false if self.admin.nil?
  end
end
