RT Bot WebUI
============

* Ruby 1.8.7+ or 1.9.2+
* Sinatra 1.3+
* Haml
* sass(scss)
* jQuery
* MySQL5.1+ / DataMapper1.2+


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install --path vendor/bundle


Run
---

    % foreman start

open http://localhost:5000


Deploy
------
use Passenger with "config.ru"
