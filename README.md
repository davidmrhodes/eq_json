# EqWoOrder

[![Build Status](https://travis-ci.org/jadekler/eq_wo_order.svg?branch=master)](https://travis-ci.org/jadekler/eq_wo_order)

RSpec equality matcher that deeply compares array without order - arrays 
of primitives, hashes, and arrays.

As multi-core/multi-threaded concurrent processing becomes more 
prevalent we will see lists of items being returned in non-deterministic
order. The idea behind this gem is that we when we're testing APIs that return 
objects with these arrays of items, we neither want to care about the
order NOR do we want to dig into the data to sort/match specific fields.
See `spec/features/eq_wo_order_spec.rb` for an extensive set of examples
showcasing this gem's usage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eq_wo_order'
```

And then execute:
 
```
$ bundle
```

Or install it yourself as:

```
$ gem install eq_wo_order
```

## Usage

```
require 'eq_wo_order'

first = [[1, 2, 3]]
second = [[3, 1, 2]]

expect(first).to eq_wo_order second
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/eq_wo_order/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
