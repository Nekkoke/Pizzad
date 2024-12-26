names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]
0.upto(9) do |idx|
  Employee.create!(
    admin: (idx == 0), # 最初のユーザーのみ管理者
    name: names[idx],
    fullname: "#{fnames[idx % fnames.size]} #{gnames[idx % gnames.size]}",
    password_digest: "pizzad"
  )
end