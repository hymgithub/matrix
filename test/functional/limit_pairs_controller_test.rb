require 'test_helper'

class LimitPairsControllerTest < ActionController::TestCase
  setup do
    @limit_pair = limit_pairs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:limit_pairs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create limit_pair" do
    assert_difference('LimitPair.count') do
      post :create, limit_pair: { first_value_id: @limit_pair.first_value_id, matrix_config_id: @limit_pair.matrix_config_id, second_value_id: @limit_pair.second_value_id }
    end

    assert_redirected_to limit_pair_path(assigns(:limit_pair))
  end

  test "should show limit_pair" do
    get :show, id: @limit_pair
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @limit_pair
    assert_response :success
  end

  test "should update limit_pair" do
    put :update, id: @limit_pair, limit_pair: { first_value_id: @limit_pair.first_value_id, matrix_config_id: @limit_pair.matrix_config_id, second_value_id: @limit_pair.second_value_id }
    assert_redirected_to limit_pair_path(assigns(:limit_pair))
  end

  test "should destroy limit_pair" do
    assert_difference('LimitPair.count', -1) do
      delete :destroy, id: @limit_pair
    end

    assert_redirected_to limit_pairs_path
  end
end
