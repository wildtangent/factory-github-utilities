# FactoryGithubUtilities

Gem to handle interaction with Github API

At present this has one task which is to get the SSH keys of a given Org and Team and return them as an array
We use this information to ensure that SSH key data is not statically vendored into various projects

## Installation

```ruby
gem 'factory-github-utilities'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory-github-utilities

## Usage

Generate a secret token in Github's account management

* The user should be part of the Github Org you want to inspect
* The token should have `org:read` permissions 
* The `username` of the user you generated the token with will be the `client-id`
* The generated token will be the `client-secret`.


```ruby
require 'factory-github-utilities'
team_keys = FactoryGithubUtilities::TeamKeys('client-id', 'client-secret', 'org-name', 'team-name', [debug])
keys = team_keys.get_keys

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/factorymedia-github_utilities. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

