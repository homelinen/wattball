require 'spec_helper'

describe "staffs/index" do

  before(:each) do
    assign(:staffs, FactoryGirl.create_list(:staff, 2))
  
  end

  it "renders a list of staffs" do
    render
    page = Capybara::Node::Simple.new( rendered  )
    page.all('table tbody tr').count.should == 2
  end

  # TODO: Check the values in the tables
end
