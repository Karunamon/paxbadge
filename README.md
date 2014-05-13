PAX Badge Notifier
==================

A very simple ruby script to watch the Official PAX twitter account.

It sends notifications via Pushover whenever that account tweets something
about badges.

I created this because the notification capabilities of Twitter are very limited.
I get enough text messages that the critical tweet, telling me that badge sales
are open could be missed in the fray. With Pushover, I will get a high-priority
alert telling me to drop everything and hit the website!

You require:

* A twitter developer account
* A Pushover account
* Pushover mobile client (Not free, but cheap.. $4.99ish)


Setup
-----

* Create a Twitter application to get the appropriate API keys. Read only access is fine.
* Create a pushover application for the same reason
* Copy config.yml.example to config.yml and fill with the relevant API keys.
* Run `bundle install` to grab the relevant gems
* Run main.rb in the background. You will be notified by Pushover when a tweet from @Official_PAX mentions badges.

A note
------

This was created for my own personal use. If it bugs out and as a result you miss your chance to buy badges,
I'm sorry, but this is not my responsibility.
