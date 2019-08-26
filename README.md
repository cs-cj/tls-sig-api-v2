# Tls::Sig::Api::V2

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/tls/sig/api/v2`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tls-sig-api-v2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tls-sig-api-v2

## Usage

    $ irb
    $ require 'tls/sig/api/v2'


```ruby
    # 初始化 server = Tls::Sig::Api::V2::Server.new("sdkappid","xxxkey") 
    server = Tls::Sig::Api::V2::Server.new(1400000000, "5bd2850fff3ecb11d7c805251c51ee463a25727bddc2385f3fa8bfee1bb93b5e")
    sig = server.gen_sig("xiaojun", 86400*180)

```    

## Reference

* [tencent IM UserSig document](https://cloud.tencent.com/document/product/269/32688)

* [node genSig code](https://github.com/tencentyun/tls-sig-api-v2-node)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tls-sig-api-v2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tls::Sig::Api::V2 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tls-sig-api-v2/blob/master/CODE_OF_CONDUCT.md).
