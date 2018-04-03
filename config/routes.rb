Rails.application.routes.draw do

  #devise_for :users
  #root to: 'entries#index'
  #resources :entries do
  #  resources :comments
  #end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'news/:id' => 'entries#show'
  delete 'news/:id' => 'entries#destroy'
  post 'news/:id' => 'entries#update'
  get 'news' => 'entries#index'
  put 'news' => 'entries#create'
  post 'news' => 'entries#create'

  get 'news/:entry_id/:comments' => 'comments#index'
  delete 'news/:entry_id/comments/:id' => 'comments#destroy'
  post 'news/:entry_id/comments/:id' => 'comments#update'
  get 'news/:entry_id/comments/:id' => 'comments#show'
  put 'news/:entry_id/comments' => 'comments#create'
  post 'news/:entry_id/comments/' => 'comments#create'

end
