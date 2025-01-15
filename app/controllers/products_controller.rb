class ProductsController < ApplicationController

  def index
    #商品一覧
    @products = Product.order("id").where(published: true)
    @kinds = ['ピザ', 'サイド', 'ドリンク']

  end

  def search #検索
    @products = Product.search(params[:q], params[:カテゴリ], params[:商品検索], params[:ジャンル]) #qは検索ワード メンバーのidでもqになるね
    render "index"
  end

  def show
    @products = Product.find(params[:id])

    #検索窓
    @size = ['S (-¥40)', 'M', 'L (+¥80)']
    @toppings = ['なし', 'チーズ増量(¥100)', 'トマト(¥80)', 'チキン追加(¥150)','イカ(¥150)']
    @quantity = ['1', '2', '3', '4']

  case @products.kinds
  when 'pizza'
    @show_toppings = true
    @show_size = true

  when 'side'
    @show_toppings = false
    @show_size = false

  when 'drink'
    @show_toppings = false
    @show_size = true
  end

  def product_params
    params.require(:product).permit(:name, :price, images: [])
  end
end
end

