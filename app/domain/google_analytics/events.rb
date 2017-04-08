module GoogleAnalytics::Events
  module Category
    INPUTS = 'Inputs'
    USER = 'User'
    EVENT = 'Event'
  end

  module Action
    SEARCH = 'Search'
    REGISTRATION = 'Registered'
    LOGIN = 'Login'
    EVENT_CREATED = 'Event Created'
    EVENT_BOOKED = 'Event Booked'
  end

  SEARCH = { category: Category::INPUTS, action: Action::SEARCH }
  REGISTRATION = { category: Category::USER, action: Action::REGISTRATION }
  LOGIN = { category: Category::USER, action: Action::LOGIN }
  EVENT_CREATED = { category: Category::EVENT, action: Action::EVENT_CREATED }
  EVENT_BOOKED = { category: Category::EVENT, action: Action::EVENT_BOOKED }
end
