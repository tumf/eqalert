Earth Quake Alert in Japan
==========================

[![Build Status](https://travis-ci.org/tumf/eqalert.png?branch=master)](https://travis-ci.org/tumf/eqalert) [![Code Climate](https://codeclimate.com/github/tumf/eqalert.png)](https://codeclimate.com/github/tumf/eqalert) [![Dependency Status](https://gemnasium.com/tumf/eqalert.png)](https://gemnasium.com/tumf/eqalert) [![Coverage Status](https://coveralls.io/repos/tumf/eqalert/badge.png)](https://coveralls.io/r/tumf/eqalert)

INSTALL
-------

### setup

    $ git clone git://github.com/tumf/eqalert.git
    $ cd eqalert
    $ bundle install

### cronlog

> https://github.com/kazuho/kaztools/blob/master/cronlog


USAGE
-----

add your crontab

     $ crontab -e
     */5 * * * * exec setlock -nX /tmp/eqalert.lock cronlog -- ruby /path/to/bin/eqalert 2>&1



[![endorse](http://api.coderwall.com/tumf/endorsecount.png)](http://coderwall.com/tumf)
