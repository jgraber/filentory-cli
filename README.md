# Filentory-cli [![Build Status](https://travis-ci.org/jgraber/filentory-cli.png?branch=master)](https://travis-ci.org/jgraber/filentory-cli) [![Code Climate](https://codeclimate.com/github/jgraber/filentory-cli.png)](https://codeclimate.com/github/jgraber/filentory-cli) [![Gem Version](https://badge.fury.io/rb/filentory-cli.png)](http://badge.fury.io/rb/filentory-cli)

A tool to create an inventory of a storage medium.

## Installation

Add this line to your application's Gemfile:

    gem 'filentory-cli'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filentory-cli

## Usage

    $ filentory-cli --log-level fatal "demo" .
     {
     "^o":"Datastore",
     "name":"demo",
     "files":[
       [
         {
           "^o":"FileEntry",
           "path":".",
           "name":"50quickideas.pdf",
           "last_modified":"2014-01-01T18:06:12+01:00",
           "size":49447,
           "checksum":"348a5b72877dcb5e0354f8eef62e5ff4e546043881dd051b9f8c2dea6ab23bb7"
         }
       ]
     }

To run the local Gem you are developing:

    $ ruby -Ilib bin/filentory-cli  --log-level fatal "demo" . 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Testing
Start the minimal web service as a endpoint to send data with this command:
    
    $ rackup features/support/config.ru
