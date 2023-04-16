# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
%w[Action Adventure Comedy Crime_and_Mystery Fantasy Historical Horror Romance Satire Science_Fiction Thriller].each do |name|
  genre = Genre.create(name: name)
  puts "create genre name: #{genre.name}"
end