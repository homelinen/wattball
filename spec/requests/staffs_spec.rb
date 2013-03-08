require 'spec_helper'
require "faker"

describe "Staffs" do
  describe "GET /staffs" do
    it "works! (now write some real specs)" do
      get staffs_path
      response.status.should be(200)
    end
  end

  describe "Create a new staff member", :type => :feature do
    it "Click New Staff Button" do
      visit staffs_path

      click_link 'New Staff'

      current_path.should == new_staff_path
    end

    it "Fill New Staff Form" do
      visit new_staff_path

      within("#new_staff") do
        # Create a new User
        # Create a new Address
        fill_in 'staff_telephone', :with => Faker::PhoneNumber.phone_number
        click_button 'Create Staff'
      end

      # Check Staff Count has increased
    end
  end
end
