require 'test_helper'

class HurdleMatchesControllerTest < ActionController::TestCase
  setup do
    @hurdle_match = hurdle_matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hurdle_matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hurdle_match" do
    assert_difference('HurdleMatch.count') do
      post :create, hurdle_match: {  }
    end

    assert_redirected_to hurdle_match_path(assigns(:hurdle_match))
  end

  test "should show hurdle_match" do
    get :show, id: @hurdle_match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hurdle_match
    assert_response :success
  end

  test "should update hurdle_match" do
    put :update, id: @hurdle_match, hurdle_match: {  }
    assert_redirected_to hurdle_match_path(assigns(:hurdle_match))
  end

  test "should destroy hurdle_match" do
    assert_difference('HurdleMatch.count', -1) do
      delete :destroy, id: @hurdle_match
    end

    assert_redirected_to hurdle_matches_path
  end
end
