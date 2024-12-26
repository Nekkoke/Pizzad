0.upto(4) do |idx|
    Order.create!(
        customer_id: idx + 1,
        created_at: Time.now,
        price: idx * 1000,
        store: "川崎店", 
        state: "arrived",
        address: "川崎市多摩区東三田"
    )
end