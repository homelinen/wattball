require 'faker'
require 'factory_girl'

FactoryGirl.define do

  factory :blog do
    title "A First Post"
    body "The first of hopefully many blog posts!"
    user { FactoryGirl.create(:staff).user }
  end

end
