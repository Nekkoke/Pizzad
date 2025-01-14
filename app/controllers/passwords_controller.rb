class PasswordsController < ApplicationController
  before_action :login_required_double

  def show
    redirect_to :account
  end

  def edit
    if current_customer
      @customer = current_customer
      else
      @customer = current_employee
    end
  end

  def update
    if current_customer
      @customer = current_customer
      current_password = params[:account][:current_password]
  
      if current_password.present?
        if @customer.authenticate(current_password)
          @customer.assign_attributes(account_params)
          if @customer.save
            redirect_to :account, notice: "パスワードを変更しました。"
          else
            render "edit"
          end
        else
          @customer.errors.add(:current_password, :wrong)
          render "edit"
        end
      else
        @customer.errors.add(:current_password, :empty)
        render "edit"
      end
    else
      @customer = current_employee
      current_password_admin = params[:account][:current_password_admin]
  
      if current_password_admin.present? 
        if @customer.authenticate(current_password_admin) 
          @customer.assign_attributes(params[:account])
          if @customer.save
            redirect_to :account, notice: "パスワードを変更しました。"
          else
            render "edit"
          end
        else
          @customer.errors.add(:current_password_admin, :wrong)
          render "edit"
        end
      else
        @customer.errors.add(:current_password_admin, :empty)
        render "edit"
      end
    end
  end
end