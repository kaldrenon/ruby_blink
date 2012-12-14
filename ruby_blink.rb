require 'gmail'
require 'json'
require 'twitter'
require 'fb_graph'

config_path = File.expand_path(File.dirname(__FILE__)) + "/config.json"
config = JSON.parse(File.read(config_path))

###########
# TWITTER #
###########

Twitter.configure do |twit_config|
  twit_config.consumer_key = config['twitter']['con_key']
  twit_config.consumer_secret = config['twitter']['con_secret']
  twit_config.oauth_token = config['twitter']['oauth_token']
  twit_config.oauth_token_secret = config['twitter']['oauth_secret']
end

# Check for new mentions on Twitter
new_mentions = 0
if(config['twitter']['last_check'])
  mentions = Twitter.mentions_timeline
  mentions.each do |mention|
    if (mention[:created_at] > Time.parse(config['twitter']['last_check']))
      new_mentions.succ
    end
  end
else
  new_mentions = Twitter.mentions_timeline.size
end
config['twitter']['last_check'] = Time.now
if new_mentions > 0
  # Blink yellow x times where x is the number of new mentions
  %x[blink1-tool --rgb 255,205,82 --blink #{new_mentions}]
end

#########
# GMAIL #
#########
gmail = Gmail.new(config['gmail']['username'],config['gmail']['password'])

# Check for new email on GMail
new_email = gmail.inbox.count(:unread)
if new_email > 0
  # Blink red x times where X is the number of new messages
  %x[blink1-tool --rgb 255,0,0 --blink #{new_email}]
end

############
# FACEBOOK #
############

# Check for Facebook notifications
fb_user = FbGraph::User.new( config['facebook']['username'], :access_token => config['facebook']['oauth_token'])
if (fb_user.notifications.count > 0)
  # Blink blue X times where X is the number of notifications
  %x[blink1-tool --rgb 0,0,255 --blink #{fb_user.notifications.count}]
end

# Cleanup
File.open(config_path,"w").write(JSON.pretty_generate(config))
