class Admin::OrdersController < Admin::Base

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
    @orders = Order.find_by(params[:id])
    @states = ['preparing', 'arrived']
  end


   def update
    @orders = Order.find_by(params[:id])
    @orders.assign_attributes(params[:order])
   if @orders.save
    if @orders.state == "canceled"
      redirect_to admin_orders_path, notice: "注文がキャンセルされました。ひどい" #うまく表示されない
    else
      redirect_to admin_orders_path, notice: "注文情報を更新しました。"
    end
   else
    render "index"
   end
  end

  def destroy
    @orders = Order.find(params[:id]) 
    @orders.destroy
      redirect_to :admin_orders, notice: "注文情報を削除しました。"
  end
end
