class Store < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :orders
  belongs_to :location

  has_one :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, reject_if: :all_blank, allow_destroy: true

  has_many :business_hours, inverse_of: :store, dependent: :destroy
  accepts_nested_attributes_for :business_hours, reject_if: :all_blank, allow_destroy: true

  validates :name,  presence: true, length: { maximum: 255 }
  validates :intro, presence: true, length: { maximum: 255 }

  default_scope -> { order(created_at: :DESC) }

  def store_and_user
    "#{self.user.email} 的商铺：#{name}"
  end
end
