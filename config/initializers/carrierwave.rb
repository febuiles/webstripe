CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJEJ5VCRBGO7O2S7Q',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = "webstripe"
end
