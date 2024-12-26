names = ["クーポン１" ,"クーポン２","クーポン３号","クーポン４"]
0.upto(3) do |idx|
    Coupon.create(
        name:names[idx],
        discount: idx * 10 + 10
    )
end