class Admin::ProductsController < Admin::Base
  # 会員一覧
  def index
    @products = Product.order("id")
      .page(params[:page]).per(15)
  end

  # 検索
  def search
    @products = Product.search(params[:q])
      .page(params[:page]).per(15)

    render "index"
  end

  def new
    @products = Product.new(price: 1000, kids: false, recommend: false, published: true)
    @kinds = ['pizza', 'side', 'drink']
    @stocks = Stock.all
  end

  def create
    @products = Product.new(params[:product])
    @kinds = ['pizza', 'side', 'drink']
    @stocks = Stock.all
    selected_stock_ids = params[:product][:stock_ids].reject(&:blank?) #チェックのみ.空白除外
    stock_quantities = params[:stock_quantities]|| {}
    if @products.save
      @products.toppings.destroy_all
      selected_stock_ids.each do |stock_id|
        quantity = stock_quantities[stock_id].to_i
        Topping.create!(product_id: @products.id, stock_id: stock_id, quantity: quantity)
      end
      redirect_to admin_products_path, notice: "商品を登録しました。"
    else
      render "new"
    end
  end

  def edit
    @products = Product.find(params[:id])
    @kinds = ['pizza', 'side', 'drink']
    @stocks = Stock.all
  end



   def update
    @products = Product.find(params[:id])
    @kinds = ['pizza', 'side', 'drink']
    @stocks = Stock.all
    @products.assign_attributes(params[:product])
    selected_stock_ids = params[:product][:stock_ids].reject(&:blank?)
    stock_quantities = params[:stock_quantities] || {}

    # 既存のToppingデータを削除して新しいものを保存（更新時）
    @products.toppings.destroy_all
   if @products.save
    selected_stock_ids.each do |stock_id|
      quantity = stock_quantities[stock_id].to_i
      Topping.create!(product_id: @products.id, stock_id: stock_id, quantity: quantity)
    end
    redirect_to admin_products_path, notice: "商品情報を更新しました。"
   else
    render "new"
   end
  end

  # 会員の削除
  def destroy
    @products = Product.find(params[:id])
    @products.destroy
  redirect_to :admin_products, notice: "商品情報を削除しました。"
  end
end
