class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :stores, dependent: :destroy
  has_many :menus, through: :stores
  has_many :orders
  has_many :addresses

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def super_admin?
    self.id == 1
  end

  def admin?
    self.has_role? :admin
  end

  def merchant?
    self.has_role? :merchant
  end

  def gender
    self.sex == 1 ? '男' : '女'
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = "#{auth.uid}@jforder.com"
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.nickname
      user.sex = auth.info.sex
      user.avatar = auth.info.headimgurl
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.wechat_data']
        user.provider = data['provider']
        user.uid = data['uid']
        user.nickname = data['info']['nickname']
        user.sex = data['info']['sex']
        user.avatar = data['info']['headimgurl']
      end
    end
  end

  def email_required?
    false
  end

  # ----------- 订单相关 ---------------
  def store_orders
    orders = []
    self.stores.each do |s|
      s.orders.each do |o|
        orders << o if o.confirmed? || o.delivered? || o.refunded?
      end
    end
    orders
  end

  def user_orders
    self.orders.where(active: true)
  end

  def unconfirm_orders
    orders = []
    stores.each do |s|
      s.orders.each do |o|
        orders << o if o.may_confirm?
      end
    end
    orders
  end

  def active_orders
    merchant? ? store_orders : user_orders
  end

end
