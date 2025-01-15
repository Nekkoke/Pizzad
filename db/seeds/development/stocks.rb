names = %w(tomato salad chicken material cola cheeze )
assorts = %w(vegetable vegetable meat)
0.upto(2) do |idx|
    stock = Stock.create!(
        name:names[idx],
        number:100,
        assort:assorts[idx]
    )
end


