require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '正常系' do
      it 'すべての値が必須であること' do
        expect(@item).to be_valid
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = '2'
        expect(@item).to be_valid
      end
      it '商品の状態についての情報が必須であること' do
        @item.sales_status_id = '2'
        expect(@item).to be_valid
      end
      it '配送料の負担についての情報が必須であること' do
        @item.shipping_fee_status_id = '2'
        expect(@item).to be_valid
      end
      it '発送元の地域について情報が必須であること' do
        @item.prefecture_id = '2'
        expect(@item).to be_valid
      end
      it '発送までの日数についての情報が必須であること' do
        @item.scheduled_delivery_id = '2'
        expect(@item).to be_valid
      end
      it '価格の範囲が、¥300~¥9,999,999の間であること（下限）' do
        @item.category_id = '300'
        expect(@item).to be_valid
      end
      it '価格の範囲が、¥300~¥9,999,999の間であること（上限）' do
        @item.category_id = '9999999'
        expect(@item).to be_valid
      end
      it '販売価格は、半角数字のみ保存可能であること' do
        @item.category_id = '300'
        expect(@item).to be_valid
      end
    end
    context '異常系' do
      it '商品名が必須であること' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it '商品の説明が必須であること' do
        @item.info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Info can't be blank"
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Category must be other than 1'
      end
      it '商品の状態についての情報が必須であること' do
        @item.sales_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Sales status must be other than 1'
      end
      it '配送料の負担についての情報が必須であること' do
        @item.shipping_fee_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Shipping fee status must be other than 1'
      end
      it '発送元の地域について情報が必須であること' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Prefecture must be other than 1'
      end
      it '発送までの日数についての情報が必須であること' do
        @item.scheduled_delivery_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Scheduled delivery must be other than 1'
      end
      it '価格についての情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it '価格の範囲が、¥300~¥9,999,999の間であること（下限）' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be greater than or equal to 300'
      end
      it '価格の範囲が、¥300~¥9,999,999の間であること（上限）' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
      it '販売価格は、半角数字のみ保存可能であること' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
