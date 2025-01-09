class Admin::OrdersController < Admin::Base
  # 会員一覧
  def index
    @orders = Order.order("id")
      .page(params[:page]).per(15)
  end

  # 検索
  def search
    @orders = Order.search(params[:q])
      .page(params[:page]).per(15)

    render "index"
  end

  def edit
    @orders = Order.find(params[:id])
    @states = ['preparing', 'arrived']
  end


   # 会員情報の更新
   def update
    @orders = Order.find(params[:id])
    @orders.assign_attributes(params[:order])
   if @orders.save
    redirect_to admin_orders_path, notice: "注文情報を更新しました。"
   else
    render "index"
   end
  end

  # 会員の削除
  def destroy
    @orders = Order.find(params[:id])
    @orders.destroy
  redirect_to :admin_orders, notice: "注文情報を削除しました。"
  end
end
