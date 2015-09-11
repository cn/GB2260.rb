# GB2260

The Ruby implementation for looking up the Chinese administrative divisions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'GB2260'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install GB2260

## Usage

The way to look up a administrative division by its GB2260 code is the basic interface
`gb2260.get(code)`:

```ruby
gb2260 = GB2260.new

division = gb2260.get(360426)
puts division  # => <GB2260-2014 江西省/九江市/德安县>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wolflee/GB2260.rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

