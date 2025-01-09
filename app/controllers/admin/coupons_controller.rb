class Admin::CouponsController < Admin::Base
  # 会員一覧
  def index
    @coupons = Coupon.order("id")
      .page(params[:page]).per(15)
  end

  # 検索
  def search
    @coupons = Coupon.search(params[:q])
      .page(params[:page]).per(15)

    render "index"
  end

  # 新規作成フォーム
  def new
    @coupons = Coupon.new(discount: 10)
  end

  # 会員の新規登録
  def create
    @coupons = Coupon.new(params[:coupon])
    if @coupons.save
      redirect_to admin_coupons_path, notice: "クーポンを登録しました。"
    else
      render "new"
    end
  end

  def edit
    @coupons = Coupon.find(params[:id])
  end


   # 会員情報の更新
   def update
    @coupons = Coupon.find(params[:id])
    @coupons.assign_attributes(params[:coupon])
   if @coupons.save
    redirect_to admin_coupons_path, notice: "クーポンを更新しました。"
   else
    render "index"
   end
  end

  # 会員の削除
  def destroy
    @coupons = Coupon.find(params[:id])
    @coupons.destroy
  redirect_to :admin_coupons, notice: "クーポンを削除しました。"
  end
end
