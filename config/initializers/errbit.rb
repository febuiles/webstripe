Airbrake.configure do |config|
  config.api_key = 'f24720630a94f5f4497e048df407b051'
  config.host    = 'mheroin-errors.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
