Rails.application.routes.draw do
   root "top#index"

    #productのルート
    resources :products do
        get"search", on: :collection
        resources :pizzas, only: [:new, :create]
    end

    #orderのルート
    resources :orders do
      post :add, on: :collection #カートのadd
        collection do
        delete :clear_cart #カートをクリア
        end
    end

    #customerのルート
    resources :customers 

     #employeeのルート
     namespace :admin do
      root to: "top#index"
      resources :customers do
        get"search", on: :collection
      end
      resources :coupons do
        get"search", on: :collection
      end
      resources :stocks do
        get"search", on: :collection
      end
      resources :orders do
        get"search", on: :collection
      end
      resources :products do
        get"search", on: :collection
      end
     end

     #session
     resource :session, only: [:create, :destroy]
end


