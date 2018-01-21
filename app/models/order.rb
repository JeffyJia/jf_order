class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store
  belongs_to :address, required: false
  include AASM
  default_scope -> {order(created_at: :desc)}

  after_create :number_generator!

  aasm column: :state do
    state :pending, initial: true
    state :paid, :confirmed, :refunded, :delivered

    event :pay do
      transitions from: :pending, to: :paid
    end

    # 过几分钟没确认自动退款
    event :confirm do
      transitions from: :paid, to: :confirmed
      # transitions from: :paid, to: :refuned
    end

    event :delivering do
      transitions from: :confirmed, to: :delivered
    end

    event :refund do
      transitions from: :paid, to: :refuned
    end

  end

  def store
    Store.find_by(id: store_id)
  end

  def items
    all_items = []
    menus = JSON.parse(self.menus)
    menus['items'].each do |item|
      menu = Menu.find_by(id: item['menu_id'])
      all_items << {menu: menu, quantity: item['quantity'], price: menu.price * item['quantity']}
    end
    all_items
  end

  def amount
    total_amount = 0
    menus = JSON.parse(self.menus)
    menus['items'].each do |item|
      menu = Menu.find_by(id: item['menu_id'])
      total_amount += menu.price * item['quantity']
    end
    total_amount / 100.to_f
  end

  def number_generator!
    self.number = "#{self.created_at.to_i + self.user_id}"
    self.save
  end
end
