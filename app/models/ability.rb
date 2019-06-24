# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.customer? ? customer_abilities : executor_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def customer_executor_abilities
    can :create, [Comment]
    can :create, [Review]

    can :update, [Comment], author_id: user.id
  end

  def customer_abilities
    guest_abilities
    customer_executor_abilities

    can :create, [Task]

    can :update, [Task], author_id: user.id

    can :complete, [Task], author_id: user.id

    can :approve_executor, [Bid]
  end

  def executor_abilities
    guest_abilities
    customer_executor_abilities

    can :create, [Bid]

    can :destroy, [Bid]
  end
end
