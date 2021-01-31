require 'rails_helper'

describe 'post機能', type: :system do
	describe '一覧機能' do
		let(:user_a) { FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@expect.com') }
		let(:user_b) { FactoryBot.create(:user, user_name: 'ユーザーB', email: 'b@expect.com') }
		let!(:post_a) { FactoryBot.create(:post, place: '行先', user: user_a ) }
		let!(:post_b) { FactoryBot.create(:post, place: '行先', user: user_b ) }

	    before do
	    	visit new_user_session_path
			fill_in 'Email', with: login_user.email
			fill_in 'Password', with: login_user.password
			click_button 'ログイン'
	    end

	    shared_examples_for 'ユーザーAが作成したpostが表示される' do
	    	it { expect(page).to have_content '行先' }
	    end

	    describe '一覧表示機能' do
			context 'ユーザーAがログインしているとき' do
				let(:login_user) { user_a }

				before do
					visit posts_path
				end

				it_behaves_like 'ユーザーAが作成したpostが表示される'
			end

			context 'ユーザーBがログインしているとき' do
				let(:login_user) { user_b }

				before do
					visit posts_path
				end

				it 'ユーザーAが作成したpostが表示される' do
					expect(page).to have_content '行先'
				end
			end
		end

		describe '詳細画面機能' do
			context 'ユーザーAがログインしているとき' do
				let(:login_user) { user_a }

				before do
					visit post_path(post_a)
				end

				it_behaves_like 'ユーザーAが作成したpostが表示される'

			end
		end

		describe '新規投稿機能' do
			context '表示の確認' do
				let(:login_user) { user_a }

				before do
					visit new_post_path
				end

				it 'Take write memoriesと表示される' do
			        expect(page).to have_content 'Take write memories'
				end
				it 'countryフォームが表示される' do
				  	expect(page).to have_field 'post[country]'
				end
			    it 'placeフォームが表示される' do
				  	expect(page).to have_field 'post[place]'
		   	    end
		   	    it 'bodyフォームが表示される' do
				  	expect(page).to have_field 'post[body]'
		   	    end
		   	    it 'priceフォームが表示される' do
				  	expect(page).to have_field 'post[price]'
		   	    end
		   	    it 'start_dateフォームが表示される' do
				  	expect(page).to have_field 'post[start_date]'
		   	    end
		   	    it 'finish_dateフォームが表示される' do
				  	expect(page).to have_field 'post[finish_date]'
		   	    end
				it '完了ボタンが表示される' do
				  	expect(page).to have_button '完了'
			    end

				it '投稿に成功する' do
					fill_in 'post[place]', with: Faker::Lorem.characters(number:5)
					select '国内', from: '国内or海外'
					click_button '完了'
					expect(page).to have_content '* A record of your trip has been posted'
				end

				it '投稿に失敗する' do
					click_button '完了'
					expect(page).to have_content 'error'
					expect(current_path).to eq('/posts')
				end
			end
		end

		describe '編集のテスト' do
			context '自分の投稿の編集画面への遷移' do
				let(:login_user) { user_a }

				before do
					visit edit_post_path(post_a)
				end
				it '遷移できる' do
					expect(current_path).to eq('/posts/' + post_a.id.to_s + '/edit')
				end
			end

			context '他人の投稿の編集画面への遷移' do
				let(:login_user) { user_a }

				before do
					visit edit_post_path(post_b)
				end
				it '遷移できない' do
					expect(current_path).to eq('/posts')
				end
			end

			context '表示の確認' do
				let(:login_user) { user_a }

				before do
					visit edit_post_path(post_a)
				end
			end
		end
	end
end

