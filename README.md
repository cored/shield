# Shield

Shield is a policies clean API for using in Rails applications. The intention
is to have an easy way to use policies inside Rails applications with a clean
and well defined API.

The basic idea is to have some PORO to handle read operations without in case
those operations get a little bit complex.

The following resources brought some inspirations to the lib:

[Rails - the Missing Parts - Policies](http://eng.joingrouper.com/blog/2014/03/20/rails-the-missing-parts-policies)

[Doman Driven Rails - Yan Pritzker](http://www.windycityrails.org/videos/2014/#6)

[7 Patterns to Refactor Fat ActiveRecord Models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

## Installation

Add this line to your application's Gemfile:

    gem 'shield'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shield

## Usage

### Simple case

```ruby
class IsActiveUser
  def initialize(user)
    @user = user
  end

  def validate
    user.email_confirmed? && user.last_login_at > 14.days.ago
  end

  private

  attr_reader :user
end

class Subscriber
  include Shield

  def subscribe(user)
    policies.with(IsActiveUser.new(user)).apply
  end
end
```

### Throwing exceptions

When calling `apply!` instead of `apply` shield will generate an exception
dynamically for you with the error message that you specified the name will be
based on the policy name plus the word error; ex. `IsActiveUserError`

```ruby
class IsActiveUser
  attr_reader :error

  def initialize(user, error)
    @error = error
    @user = user
  end

  def validate
    user.email_confirmed? && user.last_login_at > 14.days.ago
  end

  private

  attr_reader :user
end

class Subscriber
  include Shield

  def subscribe(user)
    policies.with(IsActiveUser.new(user, 'Policy failed')).apply!
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/shield/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
