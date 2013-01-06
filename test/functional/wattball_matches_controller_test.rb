require 'test_helper'

class WattballMatchesControllerTest < ActionController::TestCase
  setup do
    @wattball_match = wattball_matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wattball_matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wattball_match" do
    assert_difference('WattballMatch.count') do
      post :create, wattball_match: {  }
    end

    assert_redirected_to wattball_match_path(assigns(:wattball_match))
  end

  test "should show wattball_match" do
    get :show, id: @wattball_match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wattball_match
    assert_response :success
  end

  test "should update wattball_match" do
    put :update, id: @wattball_match, wattball_match: {  }
    assert_redirected_to wattball_match_path(assigns(:wattball_match))
  end

  test "should destroy wattball_match" do
    assert_difference('WattballMatch.count', -1) do
      delete :destroy, id: @wattball_match
    end

    assert_redirected_to wattball_matches_path
  end
end
