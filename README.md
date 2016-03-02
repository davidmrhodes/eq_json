# EqWoOrder

RSpec equality matcher that recursively sorts lists, hashes, and lists of hashes before comparing

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
