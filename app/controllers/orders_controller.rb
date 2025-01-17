class OrdersController < ApplicationController

  # クリア
  def clear_cart
    session[:cart] = []
    redirect_to orders_url, notice: "カートをクリアしました。"
  end

  def destroy
    @orders = Order.find(params[:id])
    @orders.destroy
    redirect_to [:orderhis, :account], notice: "注文情報を削除しました。"
  end

  def cancel
    @order = Order.find(params[:id])
    
    if @order.state == "prepare"  # "preparing"状態の注文のみキャンセルできるようにする
      @order.update(state: "canceled")
      redirect_to [:orderhis, :account], notice: "注文がキャンセルされました。"
    else
      redirect_to [:orderhis, :account], alert: "この注文はキャンセルできません。"
    end
  end

  def add
    # カートが未定義なら0をデフォルト値とするHashで初期化（キーは商品ID、値は数量）
    session[:cart] ||= []

    @product = Product.find(params[:item_id])

    # 商品が非公開の場合
    if !@product.published
      redirect_to products_path, notice: "この商品の発売が終了しました" 
      return # 処理を終了
    end

    # 新しい商品データ
    item = {
      order_id: session[:order_id], #注文情報に
      item_id: params[:item_id],  #urlパラメータからproductのidを取得
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
          cart_item["toppings"] == item[:toppings] #sをつけて配列として扱う
      end

      #在庫チェック
      insufficient_stock_show = check_stock_show(item)
      unless insufficient_stock_show
        redirect_to products_path, notice: "在庫が不足している商品があります" and return
      end

      if existing_item 
        # 同じ商品があれば数量を追加
        existing_item["quantity"] += item[:quantity]
        redirect_to products_path, notice: "商品をカートに追加しました。"     
      else
        # 新しい商品として追加
        session[:cart] << item
          redirect_to products_path, notice: "商品をカートに追加しました。"      
        end
      end

  

  def show
    @cart = session[:cart] || [] # セッションのカートデータを取得
    @items = @cart.map do |cart_item| # カートの各アイテムに対して処理
      product = Product.find(cart_item["item_id"]) # 商品IDを使って商品情報を取得
      cart_item.merge(product: product) # 商品データをカートアイテムにマージ
    end
  end

  def new
    if current_customer
      @customer = current_customer
      @order = Order.new(address: @customer.address)  # 顧客の住所を初期値として設定
      @coupons = Coupon.where(customer_id: @customer.id)
    else
      @order = Order.new
    end
  end

  # 注文情報追加
  def create
    session[:cart].each do |item|
      product = Product.find_by(id: item["item_id"])
      
      # 商品が非公開の場合、ordersページにリダイレクト
      if product.nil? || !product.published
        redirect_to orders_path, notice: "カート内に販売されていない商品があります。" and return
      end
    end

    @order = Order.new(order_params)
    if current_customer
      @order.customer = current_customer
    else
      @order.customer_id = 999
    end

    # カートの内容をもとに在庫数を確認
    insufficient_stock = check_stock(session[:cart])

    if insufficient_stock
      # 在庫が足りている場合、注文処理を進める
      if params[:coupon_id].present?
        coupon = Coupon.find_by(id: params[:coupon_id])
        if coupon
          @order.price = calculate_discount(params[:order][:price], coupon.discount) # 合計金額を設定
          coupon.destroy
        else
          @order.price = params[:order][:price]
        end
      else
        @order.price = params[:order][:price]
      end

      @order.state = 'prepare' # 状態を'prepare'に設定
      @order.store = params[:order][:store]

      if @order.save
        # 在庫を引く
        update_stock(session[:cart])
        render "orders/orderfin", notice: "注文が完了しました。"
      else
        render "new"
      end
    else
      # 不足している素材がある場合、エラーメッセージを表示してカートに戻す
      redirect_to orders_path, notice: "在庫が不足している商品があります"
    end
  end

  private

  # 在庫数を引くメソッド
  def update_stock(cart)
    cart.each do |item|
      product_id = item["item_id"]
      quantity = item["quantity"].to_i

      #(1)今回使う材料を取得
      toppings = Topping.where(product_id: product_id)

      toppings.each do |topping|
        stock_id = topping.stock_id  # どの材料か
        topping_quantity = topping.quantity  # その材料がどれくらい必要か

        #(2)在庫を取得
        stock = Stock.find_by(id: stock_id)
        next if stock.nil?

        #(3)在庫を引く
        required_quantity = topping_quantity * quantity
        new_stock_number = stock.number - required_quantity
        stock.update(number: new_stock_number)
      end
    end
  end

  def order_params
    params.require(:order).permit(:store, :address)  # storeとaddressを許可
  end

  def calculate_discount(price, discount)
    price = price.to_f
    price - (price * discount / 100.0).round
  end

  # 在庫チェック
  def check_stock(cart)
    insufficient_stock = []

    cart.each do |item|
      product_id = item["item_id"] # どの商品か？
      quantity = item["quantity"].to_i  # その量はいくつか？

      # (1) toppingからproduct_idはどの材料を使うのか取得
      toppings = Topping.where(product_id: product_id)

      toppings.each do |topping|
        stock_id = topping.stock_id  # どの材料か
        topping_quantity = topping.quantity  # その材料がどれくらい必要か

        # (2) 在庫の個数を取得
        stock = Stock.find_by(id: stock_id)
        next if stock.nil?

        # (3) 在庫数が足りているかチェック
        required_quantity = topping_quantity * quantity
        return false if stock.number < required_quantity  # 足りなければfalseを返す
      end
    end
    true
  end

  def check_stock_show(item)
    # 商品IDと数量を取得
    product_id = item[:item_id]
    quantity = item[:quantity].to_i
 
    # (1) toppingからproduct_idはどの材料を使うのか取得
    toppings = Topping.where(product_id: product_id)
  
    toppings.each do |topping|
      stock_id = topping.stock_id  # どの材料か
      topping_quantity = topping.quantity  # その材料がどれくらい必要か
  
      # (2) 在庫の個数を取得
      stock = Stock.find_by(id: stock_id)
      next if stock.nil?
  
      # (3) 在庫数が足りているかチェック
      required_quantity = topping_quantity * quantity
      return false if stock.number < required_quantity  # 足りなければfalseを返す
    end
  
    true  # 全ての在庫が足りていればtrueを返す
  end
end

