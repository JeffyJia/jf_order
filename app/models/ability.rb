class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
      cannot [:rolify, :destroy], User do |u|
        u.id == 1 || u.id == user.id
      end
    end

    if user.has_role? :merchant
      can [:update,  :read], User, id: user.id
      can :manage, Store, user_id: user.id
      can :create, Menu
      can [:read, :update, :destroy, :upload, :list, :remove], Menu do |menu|
        user.menus.include? menu
      end
    end

  end
end
