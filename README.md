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


Console
-------

    % ruby -Ku bin/console.rb