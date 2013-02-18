require 'spec_helper'
require 'factory_girl'

describe StaffsController do
  include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user, :admin => true)
    sign_in user
  end

  describe "GET index" do
    it "assigns all staffs as @staffs" do
      staff = FactoryGirl.create(:staff)
      get :index, {}
      assigns(:staffs).should eq([staff])
    end
  end

  describe "GET show" do
    it "assigns the requested staff as @staff" do
      staff = FactoryGirl.create(:staff)
      get :show, {:id => staff.to_param}
      assigns(:staff).should eq(staff)
    end
  end

  describe "GET new" do
    it "assigns a new staff as @staff" do
      get :new, {}
      assigns(:staff).should be_a_new(Staff)
    end
  end

  describe "GET edit" do
    it "assigns the requested staff as @staff" do
      staff = FactoryGirl.create(:staff)
      get :edit, {:id => staff.to_param}
      assigns(:staff).should eq(staff)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Staff" do
        staff_attrs = FactoryGirl.build(:staff).attributes.slice(*Staff.accessible_attributes)
        expect {
          post :create, {:staff => staff_attrs }
        }.to change(Staff, :count).by(1)
      end

      it "assigns a newly created staff as @staff" do
        staff_attrs = FactoryGirl.build(:staff).attributes.slice(*Staff.accessible_attributes)
        post :create, {:staff => staff_attrs}
        assigns(:staff).should be_a(Staff)
        assigns(:staff).should be_persisted
      end

      it "redirects to the created staff" do
        staff_attrs = FactoryGirl.build(:staff).attributes.slice(*Staff.accessible_attributes)
        post :create, {:staff => staff_attrs }
        response.should redirect_to(Staff.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved staff as @staff" do
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        post :create, {:staff => FactoryGirl.build(:user)}
        assigns(:staff).should be_a_new(Staff)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        post :create, {:staff => { "user" => User.new }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested staff" do
        staff = FactoryGirl.create(:staff)
        staff_attrs = FactoryGirl.build(:staff).attributes.slice(*Staff.accessible_attributes)
        # Assuming there are no other staffs in the database, this
        # specifies that the Staff created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Staff.last.should_receive(:update_attributes).with(staff_attrs)
        put :update, {:id => staff.to_param, :staff => staff_attrs}
      end

      it "assigns the requested staff as @staff" do
        staff = FactoryGirl.create(:staff)
        staff_attrs = staff.attributes.slice(*staff.class.accessible_attributes)
        put :update, {:id => staff.to_param, :staff => staff_attrs}
        assigns(:staff).should eq(staff)
      end

      it "redirects to the staff" do
        staff = FactoryGirl.create(:staff)
        staff_attrs = staff.attributes.slice(*staff.class.accessible_attributes)
        put :update, {:id => staff.to_param, :staff => staff_attrs}
        response.should redirect_to(staff)
      end
    end

    describe "with invalid params" do
      it "assigns the staff as @staff" do
        staff = FactoryGirl.create(:staff)
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, {:id => staff.to_param, :staff => { :user => nil }}
        assigns(:staff).should eq(staff)
      end

      it "re-renders the 'edit' template" do
        staff = FactoryGirl.create(:staff)
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        put :update, {:id => staff.to_param, :staff => { "user" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested staff" do
      staff = FactoryGirl.create(:staff)
      expect {
        delete :destroy, {:id => staff.to_param}
      }.to change(Staff, :count).by(-1)
    end

    it "redirects to the staffs list" do
      staff = FactoryGirl.create(:staff)
      delete :destroy, {:id => staff.to_param}
      response.should redirect_to(staffs_url)
    end
  end

end
