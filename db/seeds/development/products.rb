#商品一覧
Product.create([
    {name: "フォルマッジョ", price: 990, kinds: "pizza", published: true, kids: false, 
    recommend: true, explanation: "4種のチーズが濃厚なピザ。", image_url: 'formaggi.webp'},

    {name: "マルゲリータ", price: 950, kinds: "pizza", published: true, kids: false, 
    recommend: false, explanation: "トマトの酸味とモッツァレラのコクが美味しいピザ。", image_url: 'margherita.webp'},

    {name: "ペスカトーレ", price: 1600, kinds: "pizza", published: true, kids: true, 
    recommend: true, explanation: "魚介類をふんだんに詰め込んだピザ。", image_url: 'pescatore.webp'},

    {name: "パイナップルピザ", price: 850, kinds: "pizza", published: true, kids: true, 
    recommend: false, explanation: "あなたは賛成派?反対派？", image_url: 'pinapoo.webp'},

    {name: "ナゲット6ピース", price: 350, kinds: "side", published: true, kids: true, 
    recommend: false, explanation: "追加の一品に。", image_url: 'nuggets.webp'},

    {name: "ポテトフライ", price: 250, kinds: "side", published: true, kids: true, 
    recommend: false, explanation: "追加の一品に。", image_url: 'potetofry.webp'},

    {name: "コーラ", price: 120, kinds: "drink", published: true, kids: true, 
    recommend: false, explanation: "ソフトドリンク", image_url: 'cola.webp'},

    {name: "ジンジャーエール", price: 120, kinds: "drink", published: true, kids: true, 
    recommend: false, explanation: "ソフトドリンク", image_url: 'genger.webp'},

    {name: "白ワイン", price: 700, kinds: "drink", published: true, kids: true, 
    recommend: false, explanation: "お酒", image_url: 'whitewain.webp'},

    {name: "ジントニック", price: 500, kinds: "drink", published: true, kids: true, 
    recommend: false, explanation: "お酒", image_url: 'jintonic.webp'},
])