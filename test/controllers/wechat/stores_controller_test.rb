require 'test_helper'

class Wechat::StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wechat_stores_index_url
    assert_response :success
  end

  test "should get show" do
    get wechat_stores_show_url
    assert_response :success
  end

end
