0.upto(2) do |idx|
  Topping.create!(
    product_id: idx + 1, 
    stock_id: idx + 1    
  )
end


