require 'test_helper'

class MandaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manda_index_url
    assert_response :success
  end

end
