# EqJson

<!-- [![Build Status](https://travis-ci.org/jadekler/eq_wo_order.svg?branch=master)](https://travis-ci.org/jadekler/eq_wo_order) -->

RSpec equality matcher that JSON.  Outputs meaningful failure messages.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eq_json'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install eq_json
```

## Usage

```ruby
require 'eq_json'

actual = {
  name: 'Harry Potter and the Sorcerer\'s Stone',
  publisherInfo: {
    publishDate: {
      year: 2015,
      month: 3,
      day: 23
    },
    name: "ACME Publisher Inc."
  },
  author: 'J.K. Rowling'
}

expected = {
  name: 'Harry Potter and the Sorcerer\'s Stone',
  author: 'J.K. Rowling',
  publisherInfo: {
    name: "ACME Publisher Inc.",
    publishDate: {
      month: 3,
      day: 23,
      year: 2015
    }
  }
}

expect(actual).to eq_json(expected)
```
# More Documentation
[Keynote Slides](https://github.com/davidmrhodes/eq_json/blob/master/doc/eqJsonPresentation.key)

If you don't have keynote here is
[Quicktime Slide show](https://github.com/davidmrhodes/eq_json/blob/master/doc/eqJsonPresentation.m4v)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/eq_json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
