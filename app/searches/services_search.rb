class ServicesSearch < Searchlight::Search
  search_on Service.all

  searches :published, :with_future_events, :events_status, :without_user

  def search_published
    search.where(published: true)
  end

  def search_with_future_events
    search.joins(:events).where('events.start_at > ?', Time.zone.now) if with_future_events
  end

  def search_events_status
    search.joins(:events).where(events: { status: events_status })
  end

  def search_without_user
    search.where.not(user: without_user)
  end
end
