class ApplicationController < ActionController::Base
  before_action :github_data

  def welcome
  end

  private

  def github_data
    if session[:last_update_github]
      if Time.now - session[:last_update_github].to_time > 3600
        session[:last_update_github] = Time.now
        @github_data = GithubData.repo_hashed_data
        session[:github_data] = @github_data
      else
        @github_data = session[:github_data]
      end
    else
      session[:last_update_github] = Time.now
      @github_data = GithubData.repo_hashed_data
      session[:github_data] = @github_data
    end
  end
end
