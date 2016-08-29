class ServicesSearch < Searchlight::Search
  search_on Service.all

  searches :published, :with_future_events, :with_events_status, :without_user, :term

  def search_published
    search.where(published: true)
  end

  def search_with_future_events
    return unless with_future_events

    search.joins(:events).where('events.start_at > ?', Time.zone.now).distinct
  end

  def search_with_events_status
    search.joins(:events).where(events: { status: with_events_status }).distinct
  end

  def search_without_user
    search.where.not(user: without_user)
  end

  def search_term
    words = term.downcase.strip.split(' ')

    prefix = "(^|\s)#{words.shift}"

    reg_exp = words.reduce(prefix) do |memo, word|
      memo << ".+\s#{word}"
    end

    search.where("LOWER(TRIM(name)) REGEXP '#{reg_exp}'")
  end
end
