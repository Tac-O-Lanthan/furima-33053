require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー情報の保存' do
    context '正常系' do
      it 'すべての値が必須であること' do
        expect(@user).to be_valid
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'hogehoge@hugahuga'
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '異常系' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'hogehoge_hugahuga'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '123ab'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
      it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'ユーザー本名は、名字の入力が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'ユーザー本名は、名前の入力が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'ユーザー本名は、全角（漢字、ひらがな、カタカナ）での名字の入力が必須であること' do
        @user.last_name = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid'
      end
      it 'ユーザー本名は、全角（漢字、ひらがな、カタカナ）での名前の入力が必須であること' do
        @user.first_name = 'okitarou'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid'
      end
      it 'ユーザー本名のフリガナは、名字の入力が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it 'ユーザー本名のフリガナは、名前の入力が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it 'ユーザー本名のフリガナは、全角（カタカナ）での名字の入力が必須であること' do
        @user.last_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana is invalid'
      end
      it 'ユーザー本名フリガナは、全角（カタカナ）での名前の入力が必須であること' do
        @user.first_name_kana = '沖太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana is invalid'
      end
      it '生年月日が必須であること' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
      it 'パスワードは全角では登録できないこと' do
        @user.password = '１２３ＡＢＣ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
    end
  end
end
