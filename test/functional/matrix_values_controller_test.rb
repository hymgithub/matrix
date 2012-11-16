require 'test_helper'

class MatrixValuesControllerTest < ActionController::TestCase
  setup do
    @matrix_value = matrix_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matrix_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matrix_value" do
    assert_difference('MatrixValue.count') do
      post :create, matrix_value: { is_chosen: @matrix_value.is_chosen, matrix_param_id: @matrix_value.matrix_param_id, status: @matrix_value.status, value_id: @matrix_value.value_id, weight: @matrix_value.weight }
    end

    assert_redirected_to matrix_value_path(assigns(:matrix_value))
  end

  test "should show matrix_value" do
    get :show, id: @matrix_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matrix_value
    assert_response :success
  end

  test "should update matrix_value" do
    put :update, id: @matrix_value, matrix_value: { is_chosen: @matrix_value.is_chosen, matrix_param_id: @matrix_value.matrix_param_id, status: @matrix_value.status, value_id: @matrix_value.value_id, weight: @matrix_value.weight }
    assert_redirected_to matrix_value_path(assigns(:matrix_value))
  end

  test "should destroy matrix_value" do
    assert_difference('MatrixValue.count', -1) do
      delete :destroy, id: @matrix_value
    end

    assert_redirected_to matrix_values_path
  end
end
