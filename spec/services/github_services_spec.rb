require 'rails_helper'

RSpec.describe 'Github Services' do
  it 'shows the repo name' do
    GithubData.repo_name
  end
end