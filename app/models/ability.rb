class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :read, :all
      can :manage, Article, user_id: user.id
      can :create, Comment
    else
      can :read, :all
    end
  end
end
