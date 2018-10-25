unless Rails.env.test?
  # Timezones not supported for sqlite (our test db)
  Groupdate.time_zone = "Pacific Time (US & Canada)"
end
