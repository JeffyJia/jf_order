class Wechat::PaymentsController < Wechat::BaseController
  skip_before_action :verify_authenticity_token, only: :notify

  def new
    @order = current_user.orders.find_by(id: params[:order_id])
  end

  def show
    @order = current_user.orders.find_by(id: params[:order_id])
  end

  def create
    @order = current_user.orders.find_by(id: params[:order_id])
    if @order and @order.may_pay?
      @order.pay
      @order.paid_at = Time.now
      @order.save
      redirect_to wechat_payment_url(order_id: @order.id)
    else
      redirect_to wechat_orders_url
    end
  end

  def done
  end

  def notify
  end
end

