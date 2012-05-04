RT Bot
======

* Crawl friends tweets.
* Check RT Count
* Notify


Works with
----------
* Ruby 1.8.7+
* MySQL 5.1+


Install Dependencies
--------------------

    % gem install bundler
    % bundle install


Setup
-----

Config

    % cp sample.config.yml config.yml

DB

    % mysql -u your_name -p
    mysql> create database favbot;

    % ruby bin/migrate.rb


Twitter Auth
------------

    % ruby bin/auth.rb


Ues
---

update user list

    % ruby -Ku bin/crawl_userlist.rb

crawl tweets

    % ruby -Ku bin/crawl_tweets.rb -user 10 -page 2


Console
-------

    % ruby -Ku bin/console.rb