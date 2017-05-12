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

There is also a special json array matcher.  This is used to match json arrays which are arrays of JSON
objects which have a key.  The key is used to compare objects in the array.  The matcher looks for items in
the actual using the key.  It then compares the expected item and actual item that it found via the key.
  The key is passed in to the matcher with the expected value.  In the example
below a JSON array of book objects is being compared.  Each book has a bookId which is used by the matcher to
do the compare of expected and actual
```ruby
  actualArray = [
        {
            bookId: "1",
            name: "Harry Potter and the Sorcerer's Stone",
            author: "J.K. Rowling"
        },
        {
            bookId: "2",
            name: "Eragon",
            author: "Christopher Paolini",
        },
        {
            bookId: "3",
            name: "The Fellowship of the Ring",
            author: "J.R.R. Tolkien"

        }
    ]

    expectedArray = [
        {
            bookId: "3",
            name: "The Fellowship of the Ring",
            author: "J.R.R. Tolkien"

        },
        {
            bookId: "1",
            name: "Harry Potter and the Sorcerer's Stone",
            author: "J.K. Rowling"
        },
        {
            bookId: "2",
            name: "Eragon",
            author: "Christopher Paolini"
        }
    ]

    expect(actualArray).to eq_json_array_with_key(expectedArray, :bookId)

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
