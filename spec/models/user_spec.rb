require 'rails_helper'

describe User do
  let(:nickname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:password) { '12345678' }
  let(:user) { described_class.new(nickname:, email:, password:, password_confirmation: password) }

  describe '.first' do
    subject(:first_user) { described_class.first }

    before do
      create(:user, nickname:, email:)
    end

    it 'returns the expected nickname for the User' do
      expect(first_user.nickname).to eq('テスト太郎')
    end

    it 'returns the expected email for the User' do
      expect(first_user.email).to eq('test@example.com')
    end
  end

  describe 'nickname attribute validation' do
    context 'when nickname is 20 characters or less' do
      let(:nickname) { 'あいうえおかきくけこさしすせそたちつてと' } # 20文字

      it 'is valid' do
        expect(user.valid?).to be(true)
      end
    end

    context 'when nickname exceeds 20 characters' do
      let(:nickname) { 'あいうえおかきくけこさしすせそたちつてとな' } # 21文字

      it 'is invalid due to length' do
        expect(user.valid?).to be(false)
      end

      it 'has an appropriate error message' do
        user.valid?
        expect(user.errors[:nickname]).to include('is too long (maximum is 20 characters)')
      end
    end
  end

  describe 'nickname presence validation' do
    context 'when nickname is blank' do
      let(:nickname) { '' }

      it 'is invalid' do
        expect(user.valid?).to be(false)
      end

      it 'has a blank error for nickname' do
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end
    end
  end
end
