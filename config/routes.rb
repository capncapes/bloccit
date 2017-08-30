Rails.application.routes.draw do

  resources :questions
  
  resources :topics do
    resources :posts, except: [:index]
  end
  
  get 'about' => 'welcome#about'
  get 'faq' => 'welcome#faq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'
end
