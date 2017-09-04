Rails.application.routes.draw do

  get 'sponsored_posts/show'

  get 'sponsored_posts/new'

  get 'sponsored_posts/edit'

  resources :questions
  
  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end
  
  resources :users, only: [:new, :create]
  
  get 'about' => 'welcome#about'
  get 'faq' => 'welcome#faq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'
end
