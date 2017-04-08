module GoogleAnalyticsHelper
  def ga_event_date(event)
    I18n.l(event.start_at, format: :ga_event)
  end
end
