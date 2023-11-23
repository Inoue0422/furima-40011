class ShippingAddress < ApplicationRecord
  validates :post_code, presence: true
  validates :prefectures_id, presence: true
  validates :municipalities, presence: true
  validates :street_address, presence: true
  validates :telephone_number, presence: true

  belongs_to :purchase_record
end
