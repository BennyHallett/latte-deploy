Rails.application.routes.draw do
  root 'dashboard#index'

  get 'add_repo' => 'repo#add', as: :add_repo
  post 'add_repo' => 'repo#create', as: :create_repo

  # Project/Repo Details
  get '/d/:project/:repo' => 'repo#add', as: :show_repo
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
end
