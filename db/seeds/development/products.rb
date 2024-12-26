sorts = %w(pizza side drink)
names = %w(formaggi margherita pescatore pinapoo quattro 
           nuggets potetofry cola genger whitewine) #入れたい商品に合わせて自由に
0.upto(9) do |idx|
    Product.create(
        kinds: sorts[idx % sorts.size],
        name: names[idx],
        price:[300, 500, 700, 1000, 1500].sample,  #価格設定も自由に決める .sampleでランダム
        published: true,
        kids: false,
        recommend: true,
        explanation: "ここにステキな商品紹介を入れよう"
    )
    
end