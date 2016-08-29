Mail-factory
============

```
///////////////////////
//    MAIL FACTORY   //
///////////////////////
```

Mail-factory is a tool based on [middelman](http://middlemanapp.com/ "middlemanapp.com") and [premailer](http://premailer.dialect.ca/ "premailer.dialect.ca") for fast and painless building HTML e-mails.

Use stylesheets, sass, haml, partials, loops, all modern practices and compile that to old, ugly, difficult to maintain, but working good with mail clients code.

## Main features

* Support SASS
* Loops, partials and other Sinatra features
* Support any markup that middleman support

## Get started

```
bundle install
middleman server
# or bundler exec middleman server if you have troubles with different versions
```
http://127.0.0.0:4567/

when all done
```
bundle exec middleman build
```
