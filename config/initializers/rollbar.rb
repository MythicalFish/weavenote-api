if defined?(Rollbar) && ENV['ROLLBAR_TOKEN']
  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_TOKEN']
  end
end