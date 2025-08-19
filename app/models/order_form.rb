class OrderForm
  include ActiveModel::Model

  # 保存したいテーブルのカラム名 + トークンを定義
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  # バリデーション
  with_options presence: true do
    # order
    validates :user_id
    validates :item_id

    # address
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }

    # token
    validates :token
  end

  # 都道府県の選択が「---」の時は保存できないようにする
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    # 購入情報を保存し、変数orderに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    
    # 住所を保存する
    # order_idには、今作成したorderのidを代入する
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end

