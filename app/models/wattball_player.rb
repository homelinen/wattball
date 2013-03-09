class WattballPlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  belongs_to :team

  has_many :scores
  
  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dob, :org_tag, :phone_number, :team_id, :team, :user, :contact, :user_attributes, :contact_attributes

  accepts_nested_attributes_for :user, :contact

  validates_associated :user, :contact
  validates_presence_of :user, :dob, :org_tag, :team, :phone_number

  # Check the hw id is a H followed by 6 numbers, exactly
  validates :org_tag, :format => { :with => /^H[0-9]{6}$/, 
    :message => "ID should be a \"H\" followed by 6 numbers" }

end
