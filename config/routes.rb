Rails.application.routes.draw do
  root 'dashboard#index'

  get 'add_repo' => 'repo#add', as: :add_repo
  post 'add_repo' => 'repo#create', as: :create_repo

  ## Project/Repo Details ##
  get '/project/:project' => 'project#show', as: :show_project
  get '/project/:project/repo/:repo' => 'repo#show', as: :show_repo

  ## API ##
  get '/api/projects' => 'api#list_projects', as: :api_list_projects
end
