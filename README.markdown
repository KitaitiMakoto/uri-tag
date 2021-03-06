URI::Tag
========

This library extends standard bundled URI library to parse and build tag scheme URI defined in [RFC 4151][rfc4151].

Installation
------------

Install it yourself as:

    $ gem install uri-tag

Or add this line to your application's Gemfile:

    gem 'uri-tag', :require => 'uri/tag'

And then execute:

    $ bundle

Usage
-----

    require 'uri/tag'
    
    tag_uri = URI.parse('tag:example.org,2014-06-06:KitaitiMakoto:#ruby')
    tag_uri.scheme # => tag
    tag_uri.authority # => example.org
    tag_uri.date # => 2014-06-06
    tag_uri.specific # => KitaitiMakoto:
    tag_uri.fragment # => ruby
    
    another_tag = URI::Tag.build(['example.org', '2014-06-06', 'KitaitiMakoto:', 'ruby'])
    another_tag == tag_uri # => true
    
    tag_uri.date_to_time # => 2014-06-06 00:00:00 UTC
    tag_uri.date_to_time.class # => Time

See also
--------

* [RFC 4151][rfc4151] The 'tag' URI Scheme
* [tag-uri][] - Tag scheme implementation based on [Addressable][addressable]

License
-------

The same to Ruby's. See the file COPYING.

Contributing
------------

1. Clone it ( https://gitorious.org/uri-ext/uri-tag/clone )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Merge Request

[rfc4151]: http://www.ietf.org/rfc/rfc4151.txt
[tag-uri]: https://github.com/yb66/tag-uri
[addressable]: https://github.com/sporkmonger/addressable
