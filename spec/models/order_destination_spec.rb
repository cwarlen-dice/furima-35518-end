require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(
        :order_destination, user_id: user.id, item_id: item.id, price: item.price
      )
    end
    describe '送り先登録' do
      context '登録できるとき' do
        it 'すべての値が正しく入力されていれば登録できる' do
          expect(@order_destination).to be_valid
        end
        it 'buildingは空でも保存できること' do
          @order_destination.building = ''
          expect(@order_destination).to be_valid
        end
      end
      context '登録できるときできないとき' do
        it 'user_idが空では登録できない' do
          @order_destination.user_id = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("User can't be blank")
        end
        it 'item_idが空では登録できない' do
          @order_destination.item_id = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Item can't be blank")
        end
        it 'postal_codeが空では登録できない' do
          @order_destination.postal_code = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
        end
        it 'postal_codeがハイフン無しでは登録できない' do
          @order_destination.postal_code = '00000000'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include(
            'Postal code is invalid. 7 digits including hyphen(-)'
          )
        end
        it 'prefecture_idが0では登録できない' do
          @order_destination.prefecture_id = 0
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'cityが空では登録できない' do
          @order_destination.city = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("City can't be blank")
        end
        it 'addressesが空では登録できない' do
          @order_destination.addresses = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Addresses can't be blank")
        end
        it 'phone_numberが空では登録できない' do
          @order_destination.phone_number = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberが11桁より大きい数字では登録できない' do
          @order_destination.phone_number = '0123456789012'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include(
            'Phone number is invalid. Up to 11 digits number without hyphen(-)'
          )
        end
        it 'phone_numberが11桁より大きい数字では登録できない' do
          @order_destination.phone_number = '0123456789012'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include(
            'Phone number is invalid. Up to 11 digits number without hyphen(-)'
          )
        end
        it 'phone_numberが英字を含んでは登録できない' do
          @order_destination.phone_number = '0123456789a'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include(
            'Phone number is invalid. Up to 11 digits number without hyphen(-)'
          )
        end
        it 'phone_numberが全角数字を含んでは登録できない' do
          @order_destination.phone_number = '０１２３４５' # 全角数字
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include(
            'Phone number is invalid. Up to 11 digits number without hyphen(-)'
          )
        end
        it 'priceが空では登録できない' do
          @order_destination.price = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Price can't be blank")
        end
        it 'cardが空では登録できない' do
          @order_destination.card = ''
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Card can't be blank")
        end
        it 'cardが正しい値でないと登録できない' do
          @order_destination.card = 'aaa_abcdefghijk00000000000000000'
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include(
            'Card is invalid. Not enough information'
          )
        end
      end
    end
  end
end
