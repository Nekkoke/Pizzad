class ApplicationController < ActionController::Base
    private def current_customer
        Customer.find_by(id: cookies.signed[:customer_id]) if cookies.signed[:customer_id]
      end
      helper_method :current_customer

      private def current_employee
        Employee.find_by(id: cookies.signed[:employee_id]) if cookies.signed[:employee_id]
      end
      helper_method :current_employee

  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  private def login_required
    raise LoginRequired unless current_customer
  end

  private def login_required_admin
    raise LoginRequired unless current_employee
  end

  private def login_required_double
    raise LoginRequired unless current_customer || current_employee
  end
end
