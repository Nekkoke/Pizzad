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
end


