Rails.application.routes.draw do

devise_for :users
 devise_for :views

resources :clips do
  resources :comments
  member do
    put "like", to: "clips#like_clip"
    put "unlike", to: "clips#unlike_clip"
  end
end

resources :users do
  member do
    put "follow", to: "users#follow_user"
    put "unfollow", to: "users#unfollow_user"
  end
end

namespace :api do
  namespace :v1 do
    resources :clips do
      resources :comments
    end

    resources :users
  end
end

#member api method routes
put "api/v1/clips/:id/like", to: "api/v1/clips#like_clip"
put "api/v1/clips/:id/unlike", to: "api/v1/clips#unlike_clip"

put "api/v1/users/:id/follow", to: "api/v1/users#follow_user"
put "api/v1/users/:id/unfollow", to: "api/v1/users#unfollow_user"

root 'clips#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
