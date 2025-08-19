class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders
  
  validates :nickname, presence: true

  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'Please enter a mixture of alphanumeric characters.' }

  with_options presence: true do
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Please enter in full-width characters.' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Please enter in full-width characters.' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'Please enter in full-width katakana.' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'Please enter in full-width katakana.' }
  end

  validates :birth_date, presence: true
end
