module StoresHelper
  def stores_for_roles
    current_user.admin? ? @stores = Store.all : @stores = current_user.stores
  end
end
