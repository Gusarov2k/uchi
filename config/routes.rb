Rails.application.routes.draw do
  resources :top_users, only: %i[index]
  post '/search', to: 'top_users#find_github_contributions'
  get '/view', to: 'top_users#view_github', as: :github_user
  get '/download_pdf', to: 'top_users#download_pdf', as: :download
  root 'top_users#index'
end
