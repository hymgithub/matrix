require 'test_helper'

class GroupValuesControllerTest < ActionController::TestCase
  setup do
    @group_value = group_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_value" do
    assert_difference('GroupValue.count') do
      post :create, group_value: { group_id: @group_value.group_id, status: @group_value.status, value_id: @group_value.value_id }
    end

    assert_redirected_to group_value_path(assigns(:group_value))
  end

  test "should show group_value" do
    get :show, id: @group_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_value
    assert_response :success
  end

  test "should update group_value" do
    put :update, id: @group_value, group_value: { group_id: @group_value.group_id, status: @group_value.status, value_id: @group_value.value_id }
    assert_redirected_to group_value_path(assigns(:group_value))
  end

  test "should destroy group_value" do
    assert_difference('GroupValue.count', -1) do
      delete :destroy, id: @group_value
    end

    assert_redirected_to group_values_path
  end
end
