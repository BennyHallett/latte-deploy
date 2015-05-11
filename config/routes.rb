Rails.application.routes.draw do
  root 'dashboard#index'

  get 'add_repo' => 'repo#add', as: :add_repo
  post 'add_repo' => 'repo#create', as: :create_repo

  # Project/Repo Details
  get '/d/:project/:repo' => 'repo#show', as: :show_repo
end
