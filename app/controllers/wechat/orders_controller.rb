class Wechat::OrdersController < Wechat::BaseController

  def new
    store_cart = "store#{params[:store_id]}"
    @order = current_user.orders.build(store_id: params[:store_id],
                                       menus: session[store_cart].to_json)
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      store_cart = "store#{@order.store_id}"
      session[store_cart] = nil
      redirect_to new_wechat_payment_path(order_id: @order.id)
    else
      render :new
    end
  end

  def index
    @orders = current_user.active_orders
  end

  def show
    @order = Order.where(active: true).find_by(id: params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    if %w(confirmed refunded delivered).include? @order.state
      debugger
      @order.active = false
      @order.save
    else
      @order.destroy
    end
    redirect_to wechat_orders_url, notice: '订单删除成功'
  end

  private

  def order_params
    params.require(:order).permit(:store_id, :menus, :address_id)
  end
end
