class Wechat::BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'wechat'

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      store_location
      redirect_to user_wechat_omniauth_authorize_path
    end
  end

end
