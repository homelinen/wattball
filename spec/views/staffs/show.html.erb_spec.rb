require 'spec_helper'

describe "staffs/show" do
  before(:each) do
    @staff = FactoryGirl.create(:staff)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
    rendered.should match(/Address/)
    rendered.should match(/Telephone/)
  end
end
