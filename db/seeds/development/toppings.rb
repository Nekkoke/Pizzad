names = %w(cheeze tomato chicken squid)
0.upto(5) do |idx|
    Topping.create(
        {stock_id: 1, name: "cheeze", price: 100, number: 1},
        {stock_id: 2, name: "tomato", price: 80, number: 1},
        {stock_id: 3, name: "chiken", price: 150, number: 1},
        {stock_id: 4, name: "squid", price: 150, number: 1},
    )
    
end