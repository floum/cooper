# Cooper

[![Code Climate](https://codeclimate.com/github/floum/cooper/badges/gpa.svg)](https://codeclimate.com/github/floum/cooper) [![Test Coverage](https://codeclimate.com/github/floum/cooper/badges/coverage.svg)](https://codeclimate.com/github/floum/cooper/coverage)

A revisioning database project

As of now, Cooper only manages, can be a hash.

## Getting Started

Cooper uses the `ENV['HOME']` environment variable to store data.

Install cooper from the command prompt

  `gem install cooper`
    
Start populating your Cooper Item with attributes from the command line

  `cooper update name:cooper`

  `cooper update version:0.0.1 date:2015-05-29`

Retrieve data from any update (starting from 0

  `cooper read` for current status
  `cooper read --at 1` for status after first update

See `cooper help` for more

## Features
  
* cooper server

## Contributing

1. Fork it ( https://github.com/floum/cooper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
