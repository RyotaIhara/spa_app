# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  :name => 'ユーザー１', 
  :age => '10', 
  :gender => true,
  :note => '備考１'
)
User.create(
  :name => 'ユーザー２', 
  :age => '20', 
  :gender => false,
  :note => '備考２'
)
User.create(
  :name => 'ユーザー３', 
  :age => '30', 
  :gender => true,
  :note => '備考３'
)
