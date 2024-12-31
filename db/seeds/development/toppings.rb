names = %w(cheeze tomato chicken squid)
prices = [100, 80, 150, 150]

names.each_with_index do |name, idx|
  Topping.create!(
    stock_id: idx + 1, 
    name: name,        
    price: prices[idx], 
    number: 1       
  )
end
