Rails.application.routes.draw do
  resources :posts
  resources :advertisements
  
  get 'about' => 'welcome#about'
  get 'faq' => 'welcome#faq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'
end
