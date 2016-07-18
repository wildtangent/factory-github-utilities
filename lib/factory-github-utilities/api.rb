module FactoryGithubUtilities
  require 'github_api'

  # Implementation of Github API gem with some helper methods for teams
  class API
    attr_accessor :client

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret

      Github.configure do |c|
        c.basic_auth = "#{@client_id}:#{@client_secret}"
      end

      @client = Github.new
    end
  end
end
