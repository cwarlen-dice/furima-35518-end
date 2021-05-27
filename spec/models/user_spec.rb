require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it 'email,password,nickname,first_name,last_name,first_name_kana,last_name_kana,birth_dateが存在すれば登録できる' do
          expect(@user).to be_valid
        end
        it 'passwordとpassword_confirmationが英数混合6文字以上であれば登録できる' do
          @user.password = 'aaa000'
          @user.password_confirmation = 'aaa000'
          expect(@user).to be_valid
        end
      end
      context '新規登録できないとき' do
        context 'ユーザー情報' do
          it 'nicknameが空では登録できない' do
            @user.nickname = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Nickname can't be blank")
          end
          it 'emailが空では登録できない' do
            @user.email = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Email can't be blank")
          end
          it '重複したemailが存在する場合登録できない' do
            @user.save
            another_user = FactoryBot.build(:user)
            another_user.email = @user.email
            another_user.valid?
            expect(another_user.errors.full_messages).to include('Email has already been taken')
          end
          it 'emailに@を含まない場合登録できない' do
            @user.email = 'abcdegf'
            @user.valid?
            expect(@user.errors.full_messages).to include('Email is invalid')
          end
          it 'passwordが空では登録できない' do
            @user.password = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Password can't be blank")
          end
          it 'passwordが存在してもpassword_confirmationが空では登録できない' do
            @user.password_confirmation = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
          it 'passwordが5文字以下では登録できない' do
            @user.password = 'a'
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
          end
          it 'passwordが英語のみでは登録できない' do
            @user.password = 'abcdefg'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
          it 'passwordが数字のみでは登録できない' do
            @user.password = '123456'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
          it 'passwordが全角では登録できない' do
            @user.password = '１２３４５６' # 全角数字
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
        end
        context '本人情報確認' do
          it 'first_nameが空では登録できない' do
            @user.first_name = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("First name can't be blank")
          end
          it 'first_nameが全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
            @user.first_name = 'Ａ' # 全角のＡ
            @user.valid?
            expect(@user.errors.full_messages).to include('First name is invalid')
          end
          it 'last_nameが空では登録できない' do
            @user.last_name = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Last name can't be blank")
          end
          it 'last_nameが全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
            @user.last_name = 'Ａ' # 全角のＡ
            @user.valid?
            expect(@user.errors.full_messages).to include('Last name is invalid')
          end

          it 'first_name_kanaが空では登録できない' do
            @user.first_name_kana = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("First name kana can't be blank")
          end
          it 'first_name_kanaがカタカナでの入力でないと登録できない' do
            @user.first_name_kana = 'あ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
          it 'last_name_kanaが空では登録できない' do
            @user.last_name_kana = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Last name kana can't be blank")
          end
          it 'last_name_kanaがカタカナでの入力でないと登録できない' do
            @user.last_name_kana = 'あ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Last name kana is invalid')
          end
          it 'birth_dateが空では登録できない' do
            @user.birth_date = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Birth date can't be blank")
          end
        end
      end
    end
  end
end
