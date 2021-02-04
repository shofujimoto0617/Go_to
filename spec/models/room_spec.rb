require 'rails_helper'

RSpec.describe 'Roomモデルのテスト', type: :model do
	describe 'アソシエーションのテスト' do
		context 'DirectMessageとの関係' do
			it '1:Nとなっている' do
				expect(Room.reflect_on_association(:direct_messages).macro).to eq :has_many
			end
		end
		context 'Entryとの関係' do
			it '1:Nとなっている' do
				expect(Room.reflect_on_association(:entries).macro).to eq :has_many
			end
		end
	end
end