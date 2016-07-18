module FactoryGithubUtilities
  require 'active_support/core_ext/object'
  require 'factory-github-utilities/api'

  # Implmeentation of some Github Team API integrations
  class Team
    require 'factory-github-utilities/loggable'
    include Loggable

    def initialize(client_id, client_secret, org, team_name, debug = false)
      @client_id = client_id
      @client_secret = client_secret
      @org = org
      @team_name = team_name
      @debug = debug

      @api = API.new(client_id, client_secret)
    end

    # Return a list of teams for the given Github Org
    def teams
      @teams ||= @api.client.orgs.teams.list(org: @org)
    end

    # Select the team matching @team_name from the available teams in the Github Org
    def team
      @team ||= teams.select { |team| team.name == @team_name }.first
    end

    # Return the list of members on a given team
    def team_members(team_id)
      @api.client.orgs.teams.list_members(team_id)
    end

    # Return the API response for the user/keys call
    def keys_for(username)
      @api.client.users.keys.list(user: username).body
    end

    # Return array of keys and user emails
    def keys
      authorized_keys = []
      if team.present?
        log "Got Github Team '#{team.name}' for Org '#{@org}'"

        members = team_members(team.id)

        members.each do |member|
          log("Getting Member...#{member.login}")

          keys = keys_for(member.login)

          # Can't get the real email address without logging in as that user
          email = "#{member.login}@github.com"

          keys.each do |key|
            authorized_keys << [key[:key], email]
          end
        end
      else
        log("No '#{@team_name}' team for '#{@org}' found")
        log(teams.inspect)
      end
      authorized_keys
    end
  end
end
