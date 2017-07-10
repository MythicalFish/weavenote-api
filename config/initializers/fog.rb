Rails.application.config.fog = {
  provider: 'AWS',
  aws_access_key_id: ENV['SEAMLESS__AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['SEAMLESS__AWS_SECRET_ACCESS_KEY'],
  region: ENV['SEAMLESS__AWS_REGION']
}