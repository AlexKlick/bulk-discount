require 'rails_helper'
require_relative './web_mock_stubs'

RSpec.describe 'Github Services' do
  describe 'repo_name' do
    it 'returns the repo name and link' do
      stub = WebmockStubs.mock_name
      stub_request(:get, "https://api.github.com/repos/alexklick/bulk-discount")
      .to_return(status: 200, body: stub, headers: {})
      expect(GithubData.repo_name).to eq({"repo_name"=>"bulk-discount", "repo_link"=>"https://github.com/AlexKlick/bulk-discount"})
    end
  end
  describe 'repo_contributors' do
    it 'returns the contributors data' do
      stub = WebmockStubs.mock_contributors
      stub_request(:get, "https://api.github.com/repos/alexklick/bulk-discount/contributors")
      .to_return(status: 200, body: stub, headers: {})
      expect(GithubData.repo_contributors['login']).to eq('AlexKlick')
    end
  end

  describe 'repo_pr_count' do
    it 'returns the number of pull requests' do
      stub = WebmockStubs.mock_pulls
      stub_request(:get, "https://api.github.com/repos/alexklick/bulk-discount/pulls?state=all")
      .to_return(status: 200, body: stub, headers: {})
      expect(GithubData.repo_pr_count).to eq(1)
    end
  end

  describe 'repo_hashed_data' do
    it 'returns a hash of all data' do
      stub = WebmockStubs.mock_commits
      stub_request(:get, "https://api.github.com/repos/alexklick/bulk-discount/commits")
      .to_return(status: 200, body: stub, headers: {})
      expect(GithubData.repo_name).to eq({"repo_name"=>"bulk-discount", "repo_link"=>"https://github.com/AlexKlick/bulk-discount"})
    end
  end
end