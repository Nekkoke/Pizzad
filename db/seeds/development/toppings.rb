names = %w(cheeze tomato chicken)
0.upto(2) do |idx|
    Topping.create(
        stock_id:idx+1,
        name:names[idx],
        price:100,
        number:1
    )
    
end