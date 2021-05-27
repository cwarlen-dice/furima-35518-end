class Category < ActiveHash::Base
  self.data = [
    { id: 0, data: '---' },
    { id: 1, data: 'レディース' },
    { id: 2, data: 'メンズ' },
    { id: 3, data: 'ベビー・キッズ' },
    { id: 4, data: 'インテリア・住まい・小物' },
    { id: 5, data: '本・音楽・ゲーム' },
    { id: 6, data: 'おもちゃ・ホビー・グッズ' },
    { id: 7, data: '家電・スマホ・カメラ' },
    { id: 8, data: 'スポーツ・レジャー' },
    { id: 9, data: 'ハンドメイド' },
    { id: 10, data: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :items
end
