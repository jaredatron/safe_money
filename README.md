# SafeMoney

Safe Money helps prevent unwanted arithmetic errors by representing money as an Integer of cents and preventing pennies from being split up.

If you've ever represented money using floats or ints you've likely made a mistake like this:

```ruby
10.99 / 2 # => 5.495
```

You've just split a penny in half. No good!

If you're using integers you can make the same mistake but it's even harder to notice

```ruby
1099 / 2 # => 549
```

You've just thrown a penny into the well of bad math.


Safe Money prevents you from making these sorts of mistakes

```ruby
10.99.dollars / 2 # => SafeMoney::ArithmeticError: $10.99 cannot be safely divided by 2
```

## Usage

```ruby

100.cents # => $1.00

100.5.cents # => SafeMoney::CoercionError: 100.5 cannot safely be converted into cents

10.99.dollars # => $10.99

10.995.dollars # => SafeMoney::CoercionError: 10.995 cannot safely be converted into cents

1099.cents # => $10.99

100.dollars + 15.cents # => $100.15

100.dollars + 15 # => $100.15

100 + 10.dollars # => 1100

100 + 10.cents # => 110

# Bad Maths
1099 * 0.14 # => 153.86
10.99 * 0.14 # => 1.5386000000000002
1099.cents * 0.14 # => SafeMoney::ArithmeticError: $10.99 cannot be safely multiplied by 0.14

```

## Installation

Add this line to your application's Gemfile:

    gem 'safe_money'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install safe_money

## Contributing

1. Fork it ( https://github.com/deadlyicon/safe_money/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
