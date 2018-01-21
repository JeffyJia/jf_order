class Wechat::UsersController < Wechat::BaseController
  before_action :confirm_wechat_user

  def show
  end

  private

  def confirm_wechat_user
    unless current_user.provider == 'wechat'
      redirect_to wechat_stores_url
    end
  end

end
