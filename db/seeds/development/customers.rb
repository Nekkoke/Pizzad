names = %w(taro john mike sophy bill)
fnames = ["鈴木太郎" ,"ジョン太郎","鈴木マイク","ソフィー","高層ビル"]
0.upto(4) do |idx|
  Customer.create!(
    name: names[idx],
    fullname: fnames[idx],
    address: "神奈川県川崎市",
    birthed_on: "2000-12-25",
    tel: "123-456-7890",
    password: "asagao!",
    password_confirmation: "asagao!"
  )
end
