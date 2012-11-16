require 'test_helper'

class MatrixConfigsControllerTest < ActionController::TestCase
  setup do
    @matrix_config = matrix_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matrix_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matrix_config" do
    assert_difference('MatrixConfig.count') do
      post :create, matrix_config: { group_id: @matrix_config.group_id, name: @matrix_config.name, status: @matrix_config.status, version_id: @matrix_config.version_id }
    end

    assert_redirected_to matrix_config_path(assigns(:matrix_config))
  end

  test "should show matrix_config" do
    get :show, id: @matrix_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matrix_config
    assert_response :success
  end

  test "should update matrix_config" do
    put :update, id: @matrix_config, matrix_config: { group_id: @matrix_config.group_id, name: @matrix_config.name, status: @matrix_config.status, version_id: @matrix_config.version_id }
    assert_redirected_to matrix_config_path(assigns(:matrix_config))
  end

  test "should destroy matrix_config" do
    assert_difference('MatrixConfig.count', -1) do
      delete :destroy, id: @matrix_config
    end

    assert_redirected_to matrix_configs_path
  end
end
