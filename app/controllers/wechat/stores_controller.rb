class Wechat::StoresController < Wechat::BaseController

  def index
    @q = Store.ransack(params[:q])
    @stores = @q.result.includes(:location)
  end

  def show
    @store = Store.find params[:id]
    store_cart = "store#{@store.id}"
    @cart = Cart.from_hash(session[store_cart.to_sym])

    # 删除客服端里的 session 仍然保存着的商家删除或下线的菜品
    @cart.items.delete_if { |item| !item.menu.publish? || item.menu.nil? }
    session[store_cart.to_sym] = @cart.serialize
  end
end
