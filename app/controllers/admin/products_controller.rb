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

  # 会員の新規登録
  def create
    @products = Product.new(params[:product])
    @kinds = ['pizza', 'side', 'drink']
    @stocks = Stock.all
    if @products.save
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


   # 会員情報の更新
   def update
    @products = Product.find(params[:id])
    @kinds = ['pizza', 'side', 'drink']
    @stocks = Stock.all
    @products.assign_attributes(params[:product])
   if @products.save
    redirect_to admin_products_path, notice: "商品情報を更新しました。"
   else
    render "index"
   end
  end

  # 会員の削除
  def destroy
    @products = Product.find(params[:id])
    @products.destroy
  redirect_to :admin_products, notice: "商品情報を削除しました。"
  end
end
