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
github_team = FactoryGithubUtilities::Team('client-id', 'client-secret', 'org-name', 'team-name')
keys = github_team.keys
puts keys
```
## Development

### Setting up DotEnv

Open the `.env.example` file
Update the values with your Org's configuration

You will need to ensure you have granted a token with `org:read` permissions for the Github user you want to use.

### Running Specs

Run `rake spec` to run the tests.
Look in `./coverage/index.html` for test coverage metrics from `SimpleCov`

Note that the specs currently run off live API calls to ensure they are working as expected so the data you need here will have to be valid at the time of running tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/factorymedia/factorymedia-github_utilities. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

