sizes = %w(small medium large)
0.upto(2) do |product|
    0.upto(3) do |idx|
        Require.create(
            stock_id:idx+1,
            product_id:product+1,
            number:idx+1
        )
    end
end