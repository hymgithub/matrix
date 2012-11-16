require 'test_helper'

class GroupParametersControllerTest < ActionController::TestCase
  setup do
    @group_parameter = group_parameters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_parameters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_parameter" do
    assert_difference('GroupParameter.count') do
      post :create, group_parameter: { group_id: @group_parameter.group_id, parameter_id: @group_parameter.parameter_id, status: @group_parameter.status }
    end

    assert_redirected_to group_parameter_path(assigns(:group_parameter))
  end

  test "should show group_parameter" do
    get :show, id: @group_parameter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_parameter
    assert_response :success
  end

  test "should update group_parameter" do
    put :update, id: @group_parameter, group_parameter: { group_id: @group_parameter.group_id, parameter_id: @group_parameter.parameter_id, status: @group_parameter.status }
    assert_redirected_to group_parameter_path(assigns(:group_parameter))
  end

  test "should destroy group_parameter" do
    assert_difference('GroupParameter.count', -1) do
      delete :destroy, id: @group_parameter
    end

    assert_redirected_to group_parameters_path
  end
end
