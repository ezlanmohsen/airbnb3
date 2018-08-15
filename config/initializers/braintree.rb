Braintree::Configuration.environment = :sandbox
Braintree::Configuration.logger = Logger.new('log/braintree.log')
Braintree::Configuration.merchant_id = ENV['use_your_merchant_id']
Braintree::Configuration.public_key = ENV['use_your_public_key']
Braintree::Configuration.private_key = ENV['use_your_private_key']	