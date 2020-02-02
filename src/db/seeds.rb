require 'faker'

45.times do
	@product = Project.create(title: Faker::Lorem.sentence, author: Faker::Name.unique.name, to_be_completed: Faker::Date.forward(days: 90), description: Faker::Lorem.paragraph(sentence_count: 6))

	45.times do
		Task.create(title: Faker::Lorem.sentence, project: @product, author: Faker::Name.unique.name, to_be_completed: Faker::Date.forward(days: 90),  description: Faker::Lorem.paragraph(sentence_count: 6))
	end
end