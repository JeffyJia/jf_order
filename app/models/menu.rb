class Menu < ApplicationRecord
  belongs_to :store
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :name,  presence: true, length: { maximum: 255 }
  validates :intro, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  default_scope -> { order(created_at: :desc) }
  scope :published, -> { where(publish: true) }
  scope :unpublish, -> { where(publish: false) }

  before_save :set_price

  def publish!
    self.publish = true
    save
  end

  def unpublish!
    self.publish = false
    save
  end

  def real_price
    price / 100.to_f
  end

  private

    def set_price
      p = price.to_f.to_s.split(".")
      self.price = p[0].to_i * 100 + p[1].to_i * 100
    end
end
