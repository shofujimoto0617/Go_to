FactoryBot.define do
	factory :direct_message do
		message { Faker::Lorem.characters(number:5) }
		user
	end
end