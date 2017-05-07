Rails.application.config.fog = {
  provider: 'AWS',
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_KEY'],
  region: ENV['AWS_REGION']
}