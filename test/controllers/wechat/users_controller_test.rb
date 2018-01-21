require 'test_helper'

class Wechat::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get wechat_users_show_url
    assert_response :success
  end

end
