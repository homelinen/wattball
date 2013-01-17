# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    start "2013-01-17 22:21:44"
    end "2013-01-17 22:21:44"
    user nil
    tournament nil
    dsc "MyString"
    adults_number 1
    concess_number 1
  end
end
