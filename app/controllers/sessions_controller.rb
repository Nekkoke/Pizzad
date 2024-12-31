class SessionsController < ApplicationController
    def create
        customer = Customer.find_by(name: params[:name])
        if customer&.authenticate(params[:password])
          cookies.signed[:customer_id] = {value: customer.id, expires: 9999.seconds.from_now #customer_idはcookieのキー
          }
        else
          flash[:alert] = "名前かパスワードが一致しません"
        end
        redirect_to :root
      end
    
      def destroy
        cookies.delete(:customer_id)
        redirect_to :root
      end
end
