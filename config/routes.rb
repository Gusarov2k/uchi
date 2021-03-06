Rails.application.routes.draw do
  resources :top_users, only: %i[index]
  post '/search', to: 'top_users#find_github_contributions'
  get '/download_pdf', to: 'top_users#download_pdf', as: :download
  get '/download_zip', to: 'top_users#dec_zip', as: :download_zip
  root 'top_users#index'
end
