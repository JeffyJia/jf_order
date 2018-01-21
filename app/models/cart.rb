class Cart
  attr_reader :items, :store_id

  def initialize(items = [])
    @items = items
  end

  def add_item(menu_id)
    found_item = items.find {|item| item.menu_id == menu_id}
    if found_item
      found_item.increment
    else
      @items << CartItem.new(menu_id)
    end
  end

  def remove_item(menu_id)
    found_item = items.find {|item| item.menu_id == menu_id}
    found_item.increment(-1) if found_item && found_item.quantity > 0
    items.delete_if {|item| item.quantity <= 0}
  end

  def empty?
    items.delete_if {|item| item.quantity <= 0}
    items.empty?
  end

  def item(menu = nil)
    menu && (item = items.find {|item| item.menu_id == menu.id}) ? item : nil
  end

  def item_quantity(menu = nil)
    menu && (item = items.find {|item| item.menu_id == menu.id}) ? item.quantity : 0
  end

  def item_price(menu = nil)
    menu && (item = items.find {|item| item.menu_id == menu.id}) ? item.price : 0
  end

  def total_quantity
    items.reduce(0) {|sum, item| sum + item.quantity}
  end

  def total_price
    items.reduce(0) {|sum, item| sum + item.price}
  end

  def serialize
    all_items = items.map {|item| {menu_id: item.menu_id, quantity: item.quantity}}
    {items: all_items}
  end

  def self.from_hash(hash)
    if hash.nil?
      new []
    else
      new hash["items"].map {|item_hash| CartItem.new(item_hash["menu_id"], item_hash["quantity"])}
    end
  end
end
