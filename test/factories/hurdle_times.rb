# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hurdle_time, :class => 'HurdleTimes' do
    athlete nil
    time "2013-01-13 18:44:07"
    lane 1
  end
end
