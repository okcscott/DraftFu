if Rails.env == "production"
  # set credentials from ENV hash  
  pusher = {"app_id" => ENV['PUSHER_PUBLIC_KEY'], "secret" => ENV['PUSHER_SECRET_KEY'], "key" => ENV['PUSHER_API_KEY']}
else
  # get credentials from YML file
  pusher = YAML.load(File.open(Rails.root.join("config/pusher.yml")))
end

Pusher.app_id = pusher['app_id']
Pusher.key = pusher['key']
Pusher.secret = pusher['secret']