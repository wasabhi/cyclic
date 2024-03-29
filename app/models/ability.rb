class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User, :id => user.id
    can :manage, Account, :id => user.account_id
    can :manage, Ride, :user_id => user.id
  end
end
