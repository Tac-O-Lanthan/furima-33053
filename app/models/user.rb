class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :encrypted_password, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/ }
  validates :birth_date, presence: true
  # null falseだけだと""（空文字）を受け付けてしまう



  # passwordの正規表現
  # /  /    ;正規表現
  # \A \z   ;文頭と文末
  # [ ]   ;文字クラス指定
  # a-z A-Z 0-9   ;半角abc、半角ABC、半角数字
  # +   ;直前の表現の繰り返し、この場合は[ ~ ]
  # よって「全文が半角英数の繰り返しで構成されている」という正規表現である
end
