class CartController < ApplicationController
  def add
    # カートが未定義なら0をデフォルト値とするHashで初期化（キーは商品ID、値は数量）
    session[:cart] ||= Hash.new(0)

    # カートの商品IDに対する数量を追加
    session[:cart][params[:item_id]] += params[:quantity]

    redirect_to some_path, notice: "商品をカートに追加しました。"
  end

  def show
    @cart = session[:cart]
    @items = Product.find(session[:cart].pluck(:item_id))
  end
end
