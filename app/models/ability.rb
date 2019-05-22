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

  def customer_abilities
    guest_abilities

    can :manage, [Task]
  end

  def executor_abilities
    guest_abilities
  end
end
