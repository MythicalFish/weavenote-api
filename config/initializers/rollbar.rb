if defined?(Rollbar) && ENV['WEAVENOTE__ROLLBAR_TOKEN']
  Rollbar.configure do |config|
    config.access_token = ENV['WEAVENOTE__ROLLBAR_TOKEN']
  end
end