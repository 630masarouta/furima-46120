require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
    end

    context '購入ができる場合' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end

    context '購入ができない場合' do
      it '郵便番号が空では購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が半角のハイフンを含まないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '都道府県が選択されていない場合は購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @order_form.address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号にハイフンが含まれていると購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が10桁未満では購入できない' do
        @order_form.phone_number = '090123456'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では購入できない' do
        @order_form.phone_number = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角数値では購入できない' do
        @order_form.phone_number = '０９０１２３４５６７８'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end

      it 'tokenが空では購入できない' do
        @order_form.token = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end