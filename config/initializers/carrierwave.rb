CarrierWave.configure do |config|

  config.permissions = 0666
  config.directory_permissions = 0777
  
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                ENV['AWS_BUCKET_REGION']
  }
  config.fog_directory  = ENV['AMAZON_BUCKET_NAME']
  config.fog_public     = false
  
  config.storage = :fog
end