class OrdersController < ApplicationController
  def index
    #@orders = Order.order("id")
  end

  def add
    # カートが未定義なら0をデフォルト値とするHashで初期化（キーは商品ID、値は数量）
    session[:cart] ||= []

    # 新しい商品データ
    item = {
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

    # カートの商品IDに対する数量を追加(元々のコード)
    #session[:cart][params[:item_id]] += params[:quantity]

    redirect_to products_path, notice: "商品をカートに追加しました。"
  end

  def show
    @cart = session[:cart] || [] # セッションのカートデータを取得
    @items = @cart.map do |cart_item| # カートの各アイテムに対して処理
      product = Product.find(cart_item["item_id"]) # 商品IDを使って商品情報を取得
      cart_item.merge(product: product) # 商品データをカートアイテムにマージ
    end
  end

  
   #クリア
   def clear_cart
    session[:cart] = []
    redirect_to orders_path, notice: "カートをクリアしました。"
  end
end
