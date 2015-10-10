require 'test_helper'

class PropertyFixHistoriesControllerTest < ActionController::TestCase
  setup do
    @property_fix_history = property_fix_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:property_fix_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property_fix_history" do
    assert_difference('PropertyFixHistory.count') do
      post :create, property_fix_history: {  }
    end

    assert_redirected_to property_fix_history_path(assigns(:property_fix_history))
  end

  test "should show property_fix_history" do
    get :show, id: @property_fix_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property_fix_history
    assert_response :success
  end

  test "should update property_fix_history" do
    patch :update, id: @property_fix_history, property_fix_history: {  }
    assert_redirected_to property_fix_history_path(assigns(:property_fix_history))
  end

  test "should destroy property_fix_history" do
    assert_difference('PropertyFixHistory.count', -1) do
      delete :destroy, id: @property_fix_history
    end

    assert_redirected_to property_fix_histories_path
  end
end
