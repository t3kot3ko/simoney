require 'test_helper'

class RegularPlansControllerTest < ActionController::TestCase
  setup do
    @regular_plan = regular_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regular_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regular_plan" do
    assert_difference('RegularPlan.count') do
      post :create, regular_plan: { amount: @regular_plan.amount, category: @regular_plan.category, interval: @regular_plan.interval, start_date: @regular_plan.start_date, user_id: @regular_plan.user_id }
    end

    assert_redirected_to regular_plan_path(assigns(:regular_plan))
  end

  test "should show regular_plan" do
    get :show, id: @regular_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regular_plan
    assert_response :success
  end

  test "should update regular_plan" do
    patch :update, id: @regular_plan, regular_plan: { amount: @regular_plan.amount, category: @regular_plan.category, interval: @regular_plan.interval, start_date: @regular_plan.start_date, user_id: @regular_plan.user_id }
    assert_redirected_to regular_plan_path(assigns(:regular_plan))
  end

  test "should destroy regular_plan" do
    assert_difference('RegularPlan.count', -1) do
      delete :destroy, id: @regular_plan
    end

    assert_redirected_to regular_plans_path
  end
end
