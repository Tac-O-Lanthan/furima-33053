FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }    # 重複できない場合もあるのでFakerを使った方がよい
    email { Faker::Internet.free_email } # 重複できないのでFakerを使った方がよい
    password = 'hogehoge000' # 英数字混在が条件なのでFakerを使わない
    password { password }
    password_confirmation { password }
    last_name { '田中' }    # かなカナ漢字表記が条件なのでFakerを使わない
    first_name { '沖太郎' }
    last_name_kana { 'タナカ' }
    first_name_kana { 'オキタロウ' }
    birth_date { Faker::Date.in_date_period }
  end
end
