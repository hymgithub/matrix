require 'test_helper'

class MatrixParamsControllerTest < ActionController::TestCase
  setup do
    @matrix_param = matrix_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matrix_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matrix_param" do
    assert_difference('MatrixParam.count') do
      post :create, matrix_param: { matrix_config_id: @matrix_param.matrix_config_id, parameter_id: @matrix_param.parameter_id, status: @matrix_param.status }
    end

    assert_redirected_to matrix_param_path(assigns(:matrix_param))
  end

  test "should show matrix_param" do
    get :show, id: @matrix_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matrix_param
    assert_response :success
  end

  test "should update matrix_param" do
    put :update, id: @matrix_param, matrix_param: { matrix_config_id: @matrix_param.matrix_config_id, parameter_id: @matrix_param.parameter_id, status: @matrix_param.status }
    assert_redirected_to matrix_param_path(assigns(:matrix_param))
  end

  test "should destroy matrix_param" do
    assert_difference('MatrixParam.count', -1) do
      delete :destroy, id: @matrix_param
    end

    assert_redirected_to matrix_params_path
  end
end
