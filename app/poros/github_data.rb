class GithubData
  
  def self.repo_name
    repo = GithubServices.get_repo_name
    repo = JSON.parse(repo)
    hash = {}
    hash['repo_name'] = repo['name']
    hash['repo_link'] = repo['html_url']
    hash
  end

  def self.repo_contributors
    user_id = 60951642
    contributors = GithubServices.get_contributors.map do |contributor|
      if user_id == contributor['id']
        return contributor
      end
    end
  end

  def self.repo_commits_and_link
    commits = GithubServices.get_commits
    contributors = repo_contributors
    hash = {}
    user_id = 60951642
    count = JSON.parse(commits).count do |commit|
      commit['author']['id'] == user_id
    end
    hash[contributors['login']] = [count, contributors['html_url']]
    hash
  end

  def self.repo_pr_count
    pulls = GithubServices.get_pulls
    JSON.parse(pulls).count
  end

  def self.repo_hashed_data
    hash = {}
    hash.merge(repo_name)
    hash['contributors_commits_and_link'] = repo_commits_and_link
    hash['repo_pr_count'] = repo_pr_count
    hash
  end
end
