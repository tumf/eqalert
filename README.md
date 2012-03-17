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
