class AccountsController < ApplicationController
before_action :login_required_double

def new
  @customer = Customer.new(birthed_on: Date.new(2000, 1, 1))
end

def create
  @customer = Customer.new(params[:account])
  if @customer.save
    cookies.signed[:customer_id] = {value: @customer.id, expires: 1.day.from_now} #右：cookieの情報
    redirect_to root_path, notice: "会員を登録しました。"
  
   else
    render "new"
  end
end

  def show
  if current_customer
    @customer = current_customer
  else
    @customer = current_employee
  end
end

  def edit
    if current_customer
    @customer = current_customer
    else
    @customer = current_employee
  end
end

   # 会員情報の更新
   def update
    if current_customer
    @customer = current_customer
    @customer.assign_attributes(params[:account])
   if @customer.save
    redirect_to account_path, notice: "プロフィールを更新しました。"
   else
    render "index"
   end
  else
      @customer = current_employee
      @customer.assign_attributes(params[:account])
     if @customer.save
      redirect_to account_path, notice: "プロフィールを更新しました。"
     else
      render "index"
     end
    end
  end
end
