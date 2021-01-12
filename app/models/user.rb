class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}\z/ }
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/ }
  validates :birth_date, presence: true





  # 正規表現
  # /  /    ;正規表現
  # \A \z   ;文頭と文末 （ == ^ $ ）
  # [ ]   ;文字クラス指定
  # ぁ-ん ァ-ン 一-龥   ;全角かなカナ漢字
  # A-Z a-z 0-9   ;半角英数大小
  # +   ;直前の表現の繰り返し
  # .*?    ;「0回以上（*）」繰り返す「任意の文字列（.）」（最短一致）
  # {x, y} ;直前の文字列（文字クラス）がx回以上y回以下の繰り返し
  # ?=    ;肯定的先読み「hoge(?=huga)」 → hugaが直後に存在するhogeを検証する
  #       ;(?=.*[~]) → 「[~]に一致する文字列」が直後に存在する「任意の文字列0文字以上」
  #       ;0文字＝空文字を含むので、複数の(?=.*[])を同時に検証できる
end
