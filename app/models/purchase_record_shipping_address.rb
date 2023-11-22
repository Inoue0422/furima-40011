class PurchaseRecordShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefectures_id, :municipalities, :street_address, :building_name,
                :telephone_number, :token

  validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }

  validates :prefectures_id, presence: true, numericality: { other_than: 0 } # '---' は id: 0 とします

  validates :municipalities, presence: true

  validates :street_address, presence: true

  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

  validates :token, presence: true

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      purchase_record = PurchaseRecord.create(user_id:, item_id:)
      ShippingAddress.create(
        purchase_record_id: purchase_record.id,
        post_code:,
        prefectures_id:,
        municipalities:,
        street_address:,
        building_name:,
        telephone_number:
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
