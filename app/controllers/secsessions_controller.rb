class SecsessionsController < ApplicationController
    def create
        employee = Employee.find_by(name: params[:name])
        if employee&.authenticate(params[:password])
          cookies.signed[:employee_id] = {value: employee.id, expires: 9999.seconds.from_now 
          }
          redirect_to :admin_root
        else
          flash[:alert] = "名前かパスワードが一致しません"
          redirect_to :root
        end
      end
    
      def destroy
        cookies.delete(:employee_id)
        session[:cart] = []
        redirect_to :root
      end
end
