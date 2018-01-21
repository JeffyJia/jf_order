class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = current_user.active_orders
  end

  def show
    @order = Order.find params[:id]
  end

  def confirm
    @order = Order.find params[:id]
    @order.confirm! if @order
    redirect_to orders_url
  end
end
