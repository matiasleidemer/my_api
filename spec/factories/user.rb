FactoryGirl.define do
  factory :admin, class: User do
    email 'foo@bar.com'
    password '123change'
    admin true
  end

  factory :user do
    email 'foo@bar.com'
    password '123change'
    admin false
  end
end
