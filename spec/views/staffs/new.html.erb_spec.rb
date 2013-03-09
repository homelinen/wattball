require 'spec_helper'

describe "staffs/new" do
  before(:each) do
    assign(:staff, FactoryGirl.create(:staff))
 
  end

  it "renders new staff form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => staffs_path, :method => "post" do
      assert_select "input#staff_user", :name => "staff[user]"
      assert_select "input#staff_address", :name => "staff[address]"
      assert_select "input#staff_telephone", :name => "staff[telephone]"
    end
  end
end
