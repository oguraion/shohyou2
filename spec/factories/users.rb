FactoryBot.define do
  factory :user do
    id                     {1}
    nickname               {"test"}
    email                  {"test1@gmail.com"}
    password               {"00000000"}
    password_confirmation  {"00000000"}
  end
end
