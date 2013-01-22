class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  attr_accessible :adults_number, :concess_number, :dsc, :end, :start, :tournament, :tournament_id, :user_id
end
