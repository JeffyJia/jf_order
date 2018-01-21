class Wechat::CartsController < Wechat::BaseController

  def add
    @menu = Menu.find_by(id: params[:id])
    store_cart = "store#{@menu.store_id}"
    @cart = Cart.from_hash(session[store_cart.to_sym])
    @cart.add_item(@menu.id)
    session[store_cart.to_sym] = @cart.serialize
    respond_to do |format|
      format.html { redirect_to wechat_store_url(@menu.store_id) }
      format.js
    end
  end

  def minus
    @menu = Menu.find_by(id: params[:id])
    store_cart = "store#{@menu.store_id}"
    @cart = Cart.from_hash(session[store_cart.to_sym])
    @cart.remove_item(@menu.id)
    session[store_cart.to_sym] = @cart.serialize

    respond_to do |format|
      format.html { redirect_to wechat_store_url(@menu.store_id) }
      format.js
    end
  end

  def destroy
    @store = Store.find params[:store_id]
    store_cart = "store#{@store.id}"
    session[store_cart.to_sym] = nil

    redirect_to wechat_store_url(@store)
  end
end

