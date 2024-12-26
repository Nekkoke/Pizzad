sizes = %w(small medium large)
0.upto(2) do |order|
    0.upto(3) do |idx|
        Item.create(
            order_id:order+1,
            product_id:idx+1,
            number:idx+1,
            size:sizes[idx%3]
        )
    end
end