class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User::guest

    alias_action :index, :show, :search, :show_selected, to: :read_service
    alias_action :update, :publish, :unpublish, to: :manage_service

    alias_action :approve, :disapprove, :cancel_by_service, to: :manage_reservation

    can :read_service, Service

    return initialize_guest(user) if user.guest?

    initialize_user(user)
  end

  def initialize_guest(user)

  end

  def initialize_user(user)
    can :create, Service
    can :manage_service, Service, user_id: user.id

    can :manage, User, id: user.id

    can [:update, :destroy], Event do |event|
      event.service.user === user
    end

    can :create, Reservation
    can :cancel_by_client, Reservation, user_id: user.id
    can :manage_reservation, Reservation do |reservation|
      reservation.event.service.user === user
    end

    can [:create, :update, :destroy], ServicePhoto
  end
end
