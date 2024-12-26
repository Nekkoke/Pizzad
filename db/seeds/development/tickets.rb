0.upto(3) do |idx|
    Ticket.create(
        coupon_id:idx+1,
        customer_id:1
    )
end