FactoryBot.define do
  factory :user do
    nickname              { 'testuser' }
    email                 { Faker::Internet.email }
    password              { "1a#{Faker::Internet.password(min_length: 6)}" }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_furigana    { 'ヤマダ' }
    first_name_furigana   { 'タロウ' }
    date_of_birth         { '1930-01-01' }
  end
end
