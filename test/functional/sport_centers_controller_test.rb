require 'test_helper'

class SportCentersControllerTest < ActionController::TestCase
  setup do
    @sport_center = sport_centers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_centers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_center" do
    assert_difference('SportCenter.count') do
      post :create, sport_center: { address_city: @sport_center.address_city, address_line1: @sport_center.address_line1, address_line2: @sport_center.address_line2, address_postcode: @sport_center.address_postcode, address_town: @sport_center.address_town, email: @sport_center.email, name: @sport_center.name }
    end

    assert_redirected_to sport_center_path(assigns(:sport_center))
  end

  test "should show sport_center" do
    get :show, id: @sport_center
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sport_center
    assert_response :success
  end

  test "should update sport_center" do
    put :update, id: @sport_center, sport_center: { address_city: @sport_center.address_city, address_line1: @sport_center.address_line1, address_line2: @sport_center.address_line2, address_postcode: @sport_center.address_postcode, address_town: @sport_center.address_town, email: @sport_center.email, name: @sport_center.name }
    assert_redirected_to sport_center_path(assigns(:sport_center))
  end

  test "should destroy sport_center" do
    assert_difference('SportCenter.count', -1) do
      delete :destroy, id: @sport_center
    end

    assert_redirected_to sport_centers_path
  end
end
