require 'rails_helper'

RSpec.describe FormSave, type: :model do
  before do
    test_user = FactoryBot.create(:user)
    test_item = FactoryBot.create(:item)
    @form_save = FactoryBot.build(:form_save, user_id: test_user.id, item_id: test_item.id)
    sleep(1)
  end
  describe '商品購入機能' do
    context '正常系' do
      it '建物名以外の値が必須であること（カード情報はtokenの取得で検証される）' do
        expect(@form_save).to be_valid
      end
      it '建物名の入力は任意であること' do
        @form_save.building = nil
        expect(@form_save).to be_valid
      end
      it '郵便番号は7桁の半角数字と、4文字目に挿入されるハイフンで構成されていること' do
        @form_save.postal_code = '123-4567'
        expect(@form_save).to be_valid
      end
      it '電話番号は11桁以内の半角数字で、ゼロ落ちせずに認識できること' do
        @form_save.phone_number = '00000000000'
        expect(@form_save).to be_valid
      end
    end
    context '異常系' do
      it 'クレジットカード情報（を正しく入力して得られるトークン）が必須であること' do
        @form_save.token = nil
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include "Token can't be blank"
      end
      it '郵便番号には4文字目にハイフンが必須であること' do
        @form_save.postal_code = '1234567'
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include 'Postal code is invalid'
      end
      it '郵便番号が必須であること' do
        @form_save.postal_code = nil
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include "Postal code can't be blank"
      end
      it '都道府県の選択が必須であること' do
        @form_save.prefecture_id = 1
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include 'Prefecture must be other than 1'
      end
      it '市区町村が必須であること' do
        @form_save.city = nil
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include "City can't be blank"
      end
      it '番地が必須であること' do
        @form_save.address = nil
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include "Address can't be blank"
      end
      it '電話番号が11桁以内であること' do
        @form_save.phone_number = '000000000000'
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号が半角数字であること（英字を含むとき）' do
        @form_save.phone_number = 'a23456789'
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号が半角数字であること（日本語を含むとき）' do
        @form_save.phone_number = 'あ23456789'
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include 'Phone number is invalid'
      end
      it '電話番号が必須であること' do
        @form_save.phone_number = nil
        @form_save.valid?
        expect(@form_save.errors.full_messages).to include "Phone number can't be blank"
      end
    end
  end
end
