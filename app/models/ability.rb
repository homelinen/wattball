class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :read, :create, :edit, :to => :modify
    
    user ||= User.new
    if user.admin?
       can :manage, :all 
    elsif user.team
      can :manage, Team
    elsif user.staff
      can :create, Team
      can :create, User
    elsif user.athlete && user.athlete.class == WattballPlayer
      can [:modify, :new_wattball_player], Athlete
    elsif user.athlete && user.athlete.class == HurdlePlayer
      can [:modify, :new_hurdle_player], Athlete
    elsif user
      can :create, Ticket
    end

    # Everyone can read everything
    can :read, :all

    # Some read overrides
    cannot :read, Staff unless user.admin?
    cannot :read, User, :admin => true unless user.admin?
  end
end
