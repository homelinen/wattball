class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :first_name, :last_name, :admin, :registered

  before_save :default_values

  has_one :team
  has_one :wattball_player
  has_one :hurdle_player
  has_one :official
  has_one :staff

  def default_values
      self.admin = false if self.admin.nil?
      true
  end

  # Combine first and last names of user
  # (This should be taken for all users)
  def name
    [first_name, last_name].join " "
  end

  def privileged?
    self.admin? || self.staff
  end
end
