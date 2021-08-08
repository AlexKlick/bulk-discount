class GithubServices
  def self.get_repo_name
    response = Faraday.get 'https://api.github.com/repos/alexklick/bulk-discount'
    repo = response.body
  end

  def self.get_contributors
    response = Faraday.get 'https://api.github.com/repos/alexklick/bulk-discount/contributors'
    response = response.body
    JSON.parse(response)
  end

  def self.get_commits
    response = Faraday.get 'https://api.github.com/repos/alexklick/bulk-discount/commits'
    commits = response.body
  end

  def self.get_pulls
    response = Faraday.get 'https://api.github.com/repos/alexklick/bulk-discount/pulls?state=all'
    response.body
  end
end