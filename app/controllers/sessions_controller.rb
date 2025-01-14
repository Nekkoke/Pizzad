class SessionsController < ApplicationController
    def create
        customer = Customer.find_by(name: params[:name])
        if customer&.authenticate(params[:password])
          cookies.signed[:customer_id] = {value: customer.id, expires: 9999.seconds.from_now #customer_idはcookieのキー
          }
          redirect_to :products
        else
          flash[:alert] = "名前かパスワードが一致しません"
          redirect_to :root
        end
      end
    
      def destroy
        cookies.delete(:customer_id)
        session[:cart] = []
        redirect_to :root
      end
end
