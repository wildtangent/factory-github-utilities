module FactoryMedia
  module GithubUtilities
    require 'github_api'
    require 'active_support/core_ext/object'

    class GithubOrgKeys
      def initialize(client_id, client_secret, org, team_name, debug = false)
        @client_id = client_id
        @client_secret = client_secret
        @org = org
        @team_name = team_name
        @authorized_keys = []
        @debug = debug

        init_client
      end

      def init_client
        Github.configure do |c|
          c.basic_auth = "#{@client_id}:#{@client_secret}"
          c.org        = @org
        end
        @client = Github.new
      end

      def teams
        @teams ||= @client.orgs.teams.list(org: @org)
      end

      def team
        @team ||= teams.select { |team| team.name == @team_name }.first
      end

      def team_members(team_id)
        @client.orgs.teams.list_members(team_id)
      end

      def member_keys(username)
        @client.users.keys.list(user: username).body
      end

      def get_keys
        if team.present?
          log "Got Github Team '#{team.name}' for Org '#{@org}'"
          
          members = team_members(team.id)

          members.each do |member|
            log("Getting Member...#{member.login}")
            keys = member_keys(member.login)
            email = "#{member.login}@github.com"
            keys.each do |key|
              @authorized_keys << [key[:key], email].join(' ')
            end
          end
          @authorized_keys
        else
          log("No '#{team_name}' team for #{org} found")
          log(teams.inspect)
          @authorized_keys
        end
      end

      def log(message)
        puts message if @debug
      end
    end

  end
end