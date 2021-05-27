class ShippingFee < ActiveHash::Base
  self.data = [
    { id: 0, data: '---' },
    { id: 1, data: '着払い(購入者負担)' },
    { id: 2, data: '送料込み(出品者負担)' }
  ]
  include ActiveHash::Associations
  has_many :items
end
