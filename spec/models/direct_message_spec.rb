require 'rails_helper'

RSpec.describe 'DirectMessageモデルのテスト',type: :model do
	describe 'アソシエーションのテスト' do
		context 'Userモデルとの関係' do
			it 'N:1となっている' do
				expect(DirectMessage.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end

		context 'Roomモデルとの関係' do
			it 'N:1となっている' do
				expect(DirectMessage.reflect_on_association(:room).macro).to eq :belongs_to
			end
		end
	end

	describe 'バリデーションのテスト' do
		let(:user) { FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@expect.com') }
	    let!(:direct_message) { FactoryBot.build(:direct_message, user_id: user.id) }

		context 'message' do
			it '空欄でないこと' do
				direct_message.message = ''
				expect(direct_message.valid?).to eq false;
			end
		end
	end
end