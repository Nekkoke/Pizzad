Rails.application.routes.draw do
   root "top#index"

    #productのルート
    resources :products do
        get"search", on: :collection
        resources :pizzas, only: [:new, :create]
    end

    #orderのルート
    resources :orders, only: [:index, :show, :new, :create, :destroy] do
      post :add, on: :collection #カートのadd
        collection do
        delete :clear_cart #カートをクリア
        end
    end

    #退会用
    resources :outcustomers, only: [:destroy]

    #account
    resource :account, except: [:index, :destroy] do
      get :orderhis, on: :collection
    end

    #password
    resource :password, only:[:show, :edit, :update]

    #customerのルート
    resources :customers 

     #employeeのルート
     namespace :admin do
      root to: "top#index"
      resources :employees, except: [:edit, :update] do
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
     #session（従業員用）
     resource :secsession, only: [:create, :destroy]
end



