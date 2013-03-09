require 'spec_helper'
require 'factory_girl'

describe Blog do

  before(:each) do
    @blog = FactoryGirl.build(:blog)
  end

  it { @blog.should validate_presence_of :user }
  it { @blog.should validate_presence_of :title }
  it { @blog.should validate_presence_of :body }
end
