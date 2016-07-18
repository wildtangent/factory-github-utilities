require 'spec_helper'
# require 'factory-github-utilities/team'

describe FactoryGithubUtilities::Team do
  context 'with valid Github credentials' do
    let :team do
      FactoryGithubUtilities::Team.new(
        ENV['CLIENT_ID'],
        ENV['CLIENT_SECRET'],
        ENV['ORG'],
        ENV['TEAM_NAME']
      )
    end

    it 'should return some keys' do
      expect(team.keys).not_to be_empty
    end

    it 'should have some teams' do
      expect(team.teams).not_to be_empty
    end

    it 'should select the appropriate team' do
      expect(team.team.name).to eq ENV['TEAM_NAME']
    end

    it 'should return some team members' do
      team_id = team.team.id
      team_members = team.team_members(team_id)
      expect(team_members).not_to be_empty
    end

    it 'should get keys for a given user login' do
      team_id = team.team.id
      team_members = team.team_members(team_id)
      keys = team.keys_for(team_members.first.login)
      expect(keys).not_to be_blank
    end
  end

  context 'with valid Github credentials but invalid Org' do
    let :team do
      FactoryGithubUtilities::Team.new(
        ENV['CLIENT_ID'],
        ENV['CLIENT_SECRET'],
        'incorrect',
        ENV['TEAM_NAME']
      )
    end

    it 'should raise an exception when requesting team#keys' do
      expect { team.keys }.to raise_exception Github::Error::NotFound
    end

    it 'should raise and exception when requesting team#teams' do
      expect { team.teams }.to raise_exception Github::Error::NotFound
    end
  end

  context 'with valid Github credentials but invalid Team' do
    let :team do
      FactoryGithubUtilities::Team.new(
        ENV['CLIENT_ID'],
        ENV['CLIENT_SECRET'],
        ENV['ORG'],
        'invalid'
      )
    end

    it 'should not return any keys' do
      expect(team.keys).to be_empty
    end

    it 'should have some teams' do
      expect(team.teams).not_to be_empty
    end

    it 'should not return the specified team' do
      expect(team.team).to be_nil
    end
  end

  context 'with invalid Github credentials' do
    let :team do
      FactoryGithubUtilities::Team.new(
        'noentry',
        'password',
        ENV['ORG'],
        ENV['TEAM_NAME']
      )
    end

    it 'should raise an exception when requesting team#keys' do
      expect { team.keys }.to raise_exception Github::Error::Unauthorized
    end

    it 'should raise an exception when requesting team#teams' do
      expect { team.teams }.to raise_exception Github::Error::Unauthorized
    end

    it 'should raise an exception when requesting team#team' do
      expect { team.team }.to raise_exception Github::Error::Unauthorized
    end
  end
end
