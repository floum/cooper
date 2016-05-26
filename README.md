# Cooper

[![Code Climate](https://codeclimate.com/github/floum/cooper/badges/gpa.svg)](https://codeclimate.com/github/floum/cooper) [![Test Coverage](https://codeclimate.com/github/floum/cooper/badges/coverage.svg)](https://codeclimate.com/github/floum/cooper/coverage)

A schema-less revisioning database project built on [Mongoid](https://github.com/mongodb/mongoid)

## Getting Started

Install cooper from the command prompt

  `gem install cooper`

## Usage

```ruby
require 'cooper'

class Record
  include Cooper::Document

  revision_field :key
end

record = Record.new(key: 1)

record.revision_source = Cooper::RevisionSource.new

record.save
p record.key
#=> 1

record.update_attributes(key: 2)
p record.key
#=> 2

record.checkout(1)
p record.key
#=> 1
```
    
## Features

Cooper::Document behaves like(-ish for now) a Mongoid::Document

It adds the capabilities of checking out declared revision fields

## Road Map

* RevisionSource persistence
* Cooper::Document.revision_field parameters

## Tests

`rake` will run all tests

`rake spec:features` will run against mongodb (configuration is located at `spec/support/mongoid.yml`)

`rake spec:unit` runs tests in isolation

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contributing

1. Fork it ( https://github.com/floum/cooper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
