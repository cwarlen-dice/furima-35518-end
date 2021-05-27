require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品登録' do
      context '商品登録できるとき' do
        it 'image,name,info,category_id,sales_status_id,shipping_fee_id,prefecture_id,scheduled_delivery_id,priceが存在すれば登録できる' do
          expect(@item).to be_valid
        end
        it 'priceが半角の300〜9,999,999の間なら登録できる' do
          @item.price = 300
          @item.valid?
          expect(@item).to be_valid
        end
      end
      context '商品登録できるときできないとき' do
        it 'imageが空では登録できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it 'nameが40文字以上では登録できない' do
          @item.name = "0#{@item.name}"
          @item.valid?
          expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
        end
        it 'nameが空では登録できない' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it 'infoが空では登録できない' do
          @item.info = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Info can't be blank")
        end
        it 'category_idが0では登録できない' do
          @item.category_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end
        it 'sales_status_idが0では登録できない' do
          @item.sales_status_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Sales status can't be blank")
        end
        it 'shipping_fee_idが0では登録できない' do
          @item.shipping_fee_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
        end
        it 'prefecture_idが0では登録できない' do
          @item.prefecture_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'scheduled_delivery_idが0では登録できない' do
          @item.scheduled_delivery_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
        end
        it 'priceが300未満なら登録できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
        end
        it 'priceが9,999,999より大きいなら登録できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
        end
        it 'priceが全角では登録できない' do
          @item.price = '３００' # 全角３００
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
        it 'priceが半角英数字混合では登録できない' do
          @item.price = '300a'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
        it 'priceが半角英字のみでは登録できない' do
          @item.price = 'qooo'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
      end
    end
  end
end
