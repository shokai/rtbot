RT Bot
======

* Crawl friends tweets.
* Check RT Count
* Notify


Works with
----------
* Ruby 1.8.7 or 1.9.2
* MySQL 5.1+


Install Dependencies
--------------------

install rubygems

    % gem install bundler
    % bundle install  ## use system gems
    % bundle install --path vendor/bundle  ## install here


Setup
-----

Config

    % cp sample.config.yml config.yml

DB

    % mysql -u your_name -p
    mysql> create database rtbot;

    % ruby bin/db_migrate.rb


Twitter Auth
------------

    % ruby bin/auth.rb


Use
---

add user

    % ruby -Ku bin/user.rb add -name USER_NAME

update user list with your followings.

    % ruby -Ku bin/crawl_userlist.rb

crawl tweets

    % ruby -Ku bin/crawl_tweets.rb -user 10 -page 2

find tweets by RT count

    % ruby -Ku bin/find_tweets_by_rt_count.rb -rt 3

Tweet RT count. see directory "plugins/notify/".

    % ruby -Ku bin/tweet_rt_count.rb  # => dry run
    % ruby -Ku bin/tweet_rt_count.rb --tweet

dump best tweets

    % ruby -Ku bin/dump_best_tweets.rb -min_rt_count 1 -limit 10 -format html -template assets/template.haml -o best.html


Console
-------

    % ruby -Ku bin/console.rb