class Wechat::OrdersController < ApplicationController
  layout 'wechat'

  def create
    store_cart = "store#{params[:store_id]}"
    @order = current_user.orders.create(store_id: params[:store_id],
                                        menus: session[store_cart].to_json)
    session[store_cart] = nil
    redirect_to [:wechat, @order]
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to wechat_orders_url, notice: '订单删除成功'
  end
end
