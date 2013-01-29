class Athlete < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  belongs_to :team

  has_many :scores
  
  # organistationTag means an ID, avoiding naming errors here
  attr_accessible :dateOfBirth, :nationality, :organisationTag, :phoneNumber, :previousTime, :type, :team_id, :user, :contact, :user_attributes, :contact_attributes, :sex

  validates_inclusion_of :sex, :in => %w( m f )

  accepts_nested_attributes_for :user, :contact
 
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Athlete.model_name
      end
    end
    super
  end

end
