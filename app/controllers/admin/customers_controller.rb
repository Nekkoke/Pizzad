class Admin::CustomersController < Admin::Base
    # 会員一覧
    def index
      @customers = Customer.order("id")
        .page(params[:page]).per(15)
    end
  
    # 検索
    def search
      @customers = Customer.search(params[:q])
        .page(params[:page]).per(15)
  
      render "index"
    end

    # 新規作成フォーム
    def new
      @customer = Customer.new(birthed_on: Date.new(2000, 1, 1))
    end

    # 会員の新規登録
    def create
      @customer = Customer.new(params[:customer])
      if @customer.save
        redirect_to admin_customers_path, notice: "会員を登録しました。"
      else
        render "new"
      end
    end

    # 会員の削除
    def destroy
      @customer = Customer.find(params[:id])
      @customer.destroy
    redirect_to :admin_customers, notice: "会員を削除しました。"
    end
end
