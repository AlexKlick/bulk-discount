module WebmockStubs
  def self.mock_name
    {
      "id": 394068799,
      "node_id": "MDEwOlJlcG9zaXRvcnkzOTQwNjg3OTk=",
      "name": "bulk-discount",
      "full_name": "AlexKlick/bulk-discount",
      "private": false,
      "owner": {
        "login": "AlexKlick",
        "id": 60951642,
        "node_id": "MDQ6VXNlcjYwOTUxNjQy",
        "avatar_url": "https://avatars.githubusercontent.com/u/60951642?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/AlexKlick",
        "html_url": "https://github.com/AlexKlick",
        "followers_url": "https://api.github.com/users/AlexKlick/followers",
        "following_url": "https://api.github.com/users/AlexKlick/following{/other_user}",
        "gists_url": "https://api.github.com/users/AlexKlick/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/AlexKlick/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/AlexKlick/subscriptions",
        "organizations_url": "https://api.github.com/users/AlexKlick/orgs",
        "repos_url": "https://api.github.com/users/AlexKlick/repos",
        "events_url": "https://api.github.com/users/AlexKlick/events{/privacy}",
        "received_events_url": "https://api.github.com/users/AlexKlick/received_events",
        "type": "User",
        "site_admin": false
      },
      "html_url": "https://github.com/AlexKlick/bulk-discount"
    }.to_json
  end

  def self.mock_contributors
    [{
    "login": "AlexKlick",
    "id": 60951642,
    "node_id": "MDQ6VXNlcjYwOTUxNjQy",
    "avatar_url": "https://avatars.githubusercontent.com/u/60951642?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/AlexKlick",
    "html_url": "https://github.com/AlexKlick",
    "followers_url": "https://api.github.com/users/AlexKlick/followers",
    "following_url": "https://api.github.com/users/AlexKlick/following{/other_user}",
    "gists_url": "https://api.github.com/users/AlexKlick/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/AlexKlick/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/AlexKlick/subscriptions",
    "organizations_url": "https://api.github.com/users/AlexKlick/orgs",
    "repos_url": "https://api.github.com/users/AlexKlick/repos",
    "events_url": "https://api.github.com/users/AlexKlick/events{/privacy}",
    "received_events_url": "https://api.github.com/users/AlexKlick/received_events",
    "type": "User",
    "site_admin": false,
    "contributions": 42
  }].to_json
  end

  def self.mock_commits
    [{
      "sha": "57ecae9173cb5e573cdae6f31f1696fcfd55182e",
      "url": "https://api.github.com/repos/AlexKlick/bulk-discount/commits/57ecae9173cb5e573cdae6f31f1696fcfd55182e",
      "html_url": "https://github.com/AlexKlick/bulk-discount/commit/57ecae9173cb5e573cdae6f31f1696fcfd55182e",
      "comments_url": "https://api.github.com/repos/AlexKlick/bulk-discount/commits/57ecae9173cb5e573cdae6f31f1696fcfd55182e/comments",
      "author": {
        "login": "AlexKlick",
        "id": 60951642,
        "node_id": "MDQ6VXNlcjYwOTUxNjQy",
        "avatar_url": "https://avatars.githubusercontent.com/u/60951642?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/AlexKlick",
        "html_url": "https://github.com/AlexKlick",
        "followers_url": "https://api.github.com/users/AlexKlick/followers",
        "following_url": "https://api.github.com/users/AlexKlick/following{/other_user}",
        "gists_url": "https://api.github.com/users/AlexKlick/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/AlexKlick/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/AlexKlick/subscriptions",
        "organizations_url": "https://api.github.com/users/AlexKlick/orgs",
        "repos_url": "https://api.github.com/users/AlexKlick/repos",
        "events_url": "https://api.github.com/users/AlexKlick/events{/privacy}",
        "received_events_url": "https://api.github.com/users/AlexKlick/received_events",
        "type": "User",
        "site_admin": false
      }
    }].to_json
  end

  def self.mock_pulls
    {'pull'=> 'mock'}.to_json
  end

  def self.mock_holidays
    [{:date=>"2021-09-06",
  :localName=>"Labor Day",
  :name=>"Labour Day",
  :countryCode=>"US",
  :fixed=>false,
  :global=>true,
  :counties=>nil,
  :launchYear=>nil,
  :types=>["Public"]},
 {:date=>"2021-10-11",
  :localName=>"Columbus Day",
  :name=>"Columbus Day",
  :countryCode=>"US",
  :fixed=>false,
  :global=>false,
  :launchYear=>nil,
  :types=>["Public"]},
 {:date=>"2021-11-11",
  :localName=>"Veterans Day",
  :name=>"Veterans Day",
  :countryCode=>"US",
  :fixed=>false,
  :global=>true,
  :counties=>nil,
  :launchYear=>nil,
  :types=>["Public"]}].to_json
  end
end