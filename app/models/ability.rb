class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    if user.has_role? :super_admin
      can :manage, :all
    # elsif user.has_role? :admin
    #   can :read, :all
    #   cannot :manage, :admin_user
    #   cannot :read, :admin_user
    # elsif user.has_role? :support
    #   can :read, :all
    elsif user.has_role? :reseller
      can :manage, User
      can :manage, AdminUser
      can :manage, Bet
      can :manage, ComboBet
      can :read, Ledger
      can :update, Wallet
    elsif user.has_role? :sub_admin
      can :read, Ledger
      can :read, AdminUser.with_role(:sub_admin)
      can :read, User
      # can :manage, CasinoMenu
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
