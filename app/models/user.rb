class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,message: "は半角英数字混合で入力してください" }

  with_options presence: true do
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角で入力してください" }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角で入力してください" }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください" }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください" }
  end

  validates :birth_date, presence: true
end