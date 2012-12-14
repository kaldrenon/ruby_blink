# Ruby Blink
### A simple ruby program for using the ThingM blink(1)

Ruby Blink uses gems for Twitter, Facebook, and GMail to make simple use of the blink(1) by ThingM. Its current features are:
 - Notify of new mentions on Twitter
 - Notify of new Facebook notifications
 - Notify of unread email on GMail

### Config
The various tools use different methods of authentication, and Ruby Blink uses a simple JSON config file to isolate these values from the code. A sample JSON file is provided to show the format. Twitter and Facebook OAuth tokens must be requested from the developers sections of those sites.

### Dependencies
Currently, Ruby Blink assumes that the user has [blink1-tool](http://thingm.com/products/blink-1.html) installed on their machine. It also requires that the user have Ruby installed, as well as the following gems:
 - `ruby-gmail`
 - `mime`
 - `fb_graph`
 - `twitter`

To install all these in one go, run `gem install --no-ri --no-rdoc ruby-gmail mime fb_graph twitter` (prepend `sudo` or `rvm` if necessary).

Ruby Blink also currently assumes that blink1-tool is in the user's PATH.

### Using Ruby Blink
Once you've cloned Ruby Blink, copy `sample_config.json` to `config.json` and update the fields. Make sure your blink(1) is plugged in, and then simply run `ruby ruby_blink.rb`. The blink(1) will flash yellow, red, and blue, where the count of each color is the number of mentions, undread email, and notifications you currently have on the associated accounts.
