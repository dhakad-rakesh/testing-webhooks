puts 'Seeding categories...'

Market::CATEGORIES.each do |name|
  Category.find_or_create_by!(name: name,
                              kind: Category::MARKET)
end
