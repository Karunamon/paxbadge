##
puts 'Requirements setup..'
require 'twitter'
require 'pry'
require 'yaml'
require 'pushover'

conffile = File.read('./config.yml')
config = YAML.load(conffile)
$twitter_config = config[:twitter]
$pushover_config = config[:pushover]


monitor_rex = /.+?[B|b]adge[s].+?/
frequency = 120 #Number of times per hour to check. 120 = check every 30 seconds.


#Twitter client
puts 'Twitter setup..'
tw_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = $twitter_config[:api_key]
  config.consumer_secret     = $twitter_config[:api_secret]
  config.access_token        = $twitter_config[:access_token]
  config.access_token_secret = $twitter_config[:access_secret]
end

#Pushover client
puts 'Pushover setup..'
Pushover.configure do |config|
  config.user  = $pushover_config[:user_key]
  config.token = $pushover_config[:app_key]
end

def send_notification!(text)
  Pushover.notification(message: text, title: 'PAX Badge Warning System ALERT', priority: 'emergency', sound: 'Alien Alarm')
end

def send_notification(text)
  Pushover.notification(message: text, title: 'Pax Badge Warning System')
end


send_notification("Badge monitor started at #{Time.now.to_s}")

#Monitor loop
$id = 0
puts 'Entering monitor loop!'

loop do
  tw_result = tw_client.user_timeline('Official_PAX')[0]
  tw_match = tw_result.text.match(monitor_rex)
  if tw_match.nil? #Didn't match. Move on.
      puts 'No match yet. Content: ' + tw_result.text
      sleep 30
      next
  elsif tw_result.id == $id #It matched, but we got that tweet already. Move on.
     puts 'Old matching tweet, not notifying. Content: ' + tw_result.text
     sleep 30
     next
  else
    puts 'MATCHED!! Content: ' + tw_result.text
    send_notification!("Badge tweet sighted! Content: #{tw_result.text}") #HOLY CRAP IT MATCHED!
    $id = tw_result.id
    sleep 30
    next
  end
end
