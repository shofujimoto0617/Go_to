FactoryBot.define do
	factory :post do
		country { 1 }
		place { Faker::Lorem.characters(number:5) }
		body { Faker::Lorem.characters(number:20) }
		price { Faker::Lorem.characters(number:4) }
		user
	end
end