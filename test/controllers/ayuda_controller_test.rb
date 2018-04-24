require 'test_helper'

class AyudaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ayuda_index_url
    assert_response :success
  end

end
