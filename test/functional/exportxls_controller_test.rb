require 'test_helper'

class ExportxlsControllerTest < ActionController::TestCase
  test "should get export" do
    get :export
    assert_response :success
  end

end
