class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :read, :create, :edit, :to => :modify
    alias_action :read, :edit, :destroy, :to => :self_maintain
    
    user ||= User.new
    if user.team
      can :self_maintain, Team, :user => user
    elsif user.staff
      can :create, Team
      can :create, User
    elsif user.wattball_player
      can :self_maintain, WattballPlayer
    elsif user.hurdle_player
      can :self_maintain, HurdlePlayer
    end

    # All users have these rights
    if user
      can :create, Ticket
      can :edit, user
    end

    # Everyone can read everything
    can :read, :all
    cannot :index, WattballPlayer unless user.privileged?

    cannot :manage, Ticket if !user.registered?

    # Some read overrides
    cannot :read, Staff unless user.admin?
    cannot :read, User, :admin => true unless user.admin?

    can :create, User
    can :create, WattballPlayer

    can :manage, :all if user.admin?
  end
end
