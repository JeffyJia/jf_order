module ApplicationHelper
  include LetterAvatar::AvatarHelper

  def order_state(order)
    case order.state
      when 'pending'
        '待支付'
      when 'paid'
        '已支付'
      when 'confirmed'
        '已接单'
      when 'refunded'
        '已退款'
      when 'delivered'
        '已完成'
      else
        '已失效'
    end
  end

  # 重定向到存储的地址或者默认地址
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # 存储后面需要使用的地址
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
