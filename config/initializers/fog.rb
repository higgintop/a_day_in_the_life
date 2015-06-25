if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
else
  CarrierWave.configure do |config|
     config.storage = :fog
     config.fog_credentials = {
       :provider               => 'AWS',
       :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],
       :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
       :region                 => 'us-east-1'
     }
   config.fog_directory  = 'a-day-in-the-life'
  end

end
