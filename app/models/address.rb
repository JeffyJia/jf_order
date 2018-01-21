class Address < ApplicationRecord
  belongs_to :user
  has_one :order

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :info, presence: true

  def address_info
    "#{name}-#{phone_number}-#{info}"
  end

end
