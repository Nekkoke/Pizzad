class TopController < ApplicationController
  def index
  end

  def new
    @customer = Customer.new(birthed_on: Date.new(2000, 1, 1))
  end

  def create
    @customer = Customer.new(params[:customer])
      if @customer.save
        redirect_to admin_customers_path, notice: "会員を登録しました。"
      else
        render "new"
      end
  end
end
