Rails.application.routes.draw do

  get 'comentario/index'

  post 'comentario/creat'=>'comentario#creat' 

  get 'articulo/index'

  get 'articulo/list'

  get 'articulo/logout'

  get 'articulo/new'

  post 'articulo/creat'=>'articulo#creat' 

  get 'articulo/public'

  get 'articulo/:id' => 'articulo#public'

  get 'welcome/index'

  get 'login/index'

  get 'welcome/articulos'

  get 'welcome/about'

  get 'welcome/contacto'

  get 'login/new'
  
  post 'login/creat'=>'login#creat'

  get 'login/loginIn'

  post 'login/access'=>'login#access' 
  


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  #   get 'products/:id' => 'catalog#view'
  # Example of regular route:

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
