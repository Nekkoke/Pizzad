class OrdersController < ApplicationController
  def add
    # カートが未定義なら0をデフォルト値とするHashで初期化（キーは商品ID、値は数量）
    session[:cart] ||= []

    # 新しい商品データ
    item = {
      order_id: session[:order_id], #注文情報に
      item_id: params[:item_id],
      name: params[:name], #商品名
      size: params[:size],
      toppings: params[:topping],
      price: params[:price].to_i,
      quantity: params[:quantity].to_i
    }

   
    # カートに同じ商品が存在するか確認
      existing_item = session[:cart].find do |cart_item|
        cart_item["item_id"] == item[:item_id] &&
          cart_item["size"] == item[:size] &&
          cart_item["topping"] == item[:topping]
      end

      if existing_item
        # 同じ商品があれば数量を追加
        existing_item["quantity"] += item[:quantity]
      else
        # 新しい商品として追加
        session[:cart] << item
      end

    redirect_to products_path, notice: "商品をカートに追加しました。"
  end

  def show
    @cart = session[:cart] || [] # セッションのカートデータを取得
    @items = @cart.map do |cart_item| # カートの各アイテムに対して処理
      product = Product.find(cart_item["item_id"]) # 商品IDを使って商品情報を取得
      cart_item.merge(product: product) # 商品データをカートアイテムにマージ
    end
  end

  def new
    @customer = current_customer
    @order = Order.new(address: @customer.address)  # 顧客の住所を初期値として設定
  end

  # 注文情報追加
  def create
    @order = Order.new(order_params)
    @order.customer = current_customer 
    @order.price = params[:order][:price] # 合計金額を設定
    @order.state = 'prepare' # 状態を'prepare'に設定
    @order.store = params[:order][:store]
  if @order.save
    render "orders/orderfin", notice: "注文が完了しました。"
  
   else
    render "new"
   end
  end

   #クリア
   def clear_cart
    session[:cart] = []
    redirect_to orders_url, notice: "カートをクリアしました。"
  end

  def order_params
    params.require(:order).permit(:store, :address)  # storeとaddressを許可
  end
end