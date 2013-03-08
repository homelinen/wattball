require 'spec_helper'

describe "staffs/edit" do
  before(:each) do
    @staff = FactoryGirl.create(:staff)
  end

  it "renders the edit staff form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => staffs_path(@staff), :method => "post" do
      assert_select "input#staff_user", :name => "staff[user]"
      assert_select "input#staff_address", :name => "staff[address]"
      assert_select "input#staff_telephone", :name => "staff[telephone]"
    end
  end
end
