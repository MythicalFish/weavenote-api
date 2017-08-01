Rails.application.config.fog = {
  provider: 'AWS',
  aws_access_key_id: ENV['WEAVENOTE__AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['WEAVENOTE__AWS_SECRET_ACCESS_KEY'],
  region: ENV['WEAVENOTE__AWS_REGION']
}