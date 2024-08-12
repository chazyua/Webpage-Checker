# Webpage checker bot template

Script checks whether any changes were introduced to the webpage in the last 8 hours. If there were, telegram bot will send me a message.

## Steps:

1. *Telegram Bot*

Open Telegram and search for the BotFather.
Use /start to initiate a conversation with the BotFather.
Use /newbot to create a new bot and follow the instructions.
Save the bot token provided by the BotFather.

2. *Customize script*

3. *Deploy*

Ensure Ruby and necessary gems are installed.

```gem install telegram-bot-ruby
gem install dotenv
```

4. *Set Up Cron Jobs*

`crontab -e` to add the cron jobs.

```
0 8 * * * /usr/bin/ruby /path/to/website_monitor_bot.rb
0 12 * * * /usr/bin/ruby /path/to/website_monitor_bot.rb
0 18 * * * /usr/bin/ruby /path/to/website_monitor_bot.rb
```
