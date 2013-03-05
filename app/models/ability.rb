class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :read, :create, :edit, :to => :modify
    alias_action :read, :edit, :destroy, :to => :self_maintain
    
    user ||= User.new
    if user.admin?
       can :manage, :all 
    elsif user.team
      can :self_maintain, Team
    elsif user.staff
      can :create, Team
      can :create, User
    elsif user.wattball_player
      can :self_maintain, WattballPlayer
    elsif user.hurdle_player
      can :self_maintain, hurdlePlayer
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
