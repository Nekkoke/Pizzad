class Admin::StocksController < Admin::Base
  # 会員一覧
  def index
    @stocks = Stock.order("id")
      .page(params[:page]).per(15)
  end

  # 検索
  def search
    @stocks = Stock.search(params[:q])
      .page(params[:page]).per(15)

    render "index"
  end

  # 新規作成フォーム
  def new
    @stocks = Stock.new(number: 10)
    @assorts = ['vegerable', 'meat', 'seafood', 'others']
  end

  # 会員の新規登録
  def create
    @stocks = Stock.new(params[:stock])
    @assorts = ['vegerable', 'meat', 'seafood', 'others']
    if @stocks.save
      redirect_to admin_stocks_path, notice: "在庫情報を登録しました。"
    else
      render :new, status: :unprocessable_entity #ステータスコード422 
    end
  end

  def edit
    @stocks = Stock.find(params[:id])
    @assorts = ['vegerable', 'meat', 'seafood', 'others']
  end


   # 会員情報の更新
   def update
    @stocks = Stock.find(params[:id])
    @assorts = ['vegerable', 'meat', 'seafood', 'others']
    @stocks.assign_attributes(params[:stock])
   if @stocks.save
    redirect_to admin_stocks_path, notice: "在庫情報を更新しました。"
   else
    render "index"
   end
  end

  # 会員の削除
  def destroy
    @stocks = Stock.find(params[:id])
    @stocks.destroy
  redirect_to :admin_stocks, notice: "在庫情報を削除しました。"
  end

  def stock_params
    params.require(:stock).permit(:name, :number, :assort)
  end
end
