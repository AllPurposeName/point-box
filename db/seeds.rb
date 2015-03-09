# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "DJ", password: "pw")
User.create(name: "Kaitryn", password: "pw", role: 1)

points = (User.first.points.create([{value: 1, status: false}, {value: 1, status: false}, {value: 1, status: false}]))
points2 = (User.last.points.create([{value: 1, status: false}]))
rewards = (Reward.create([{name: "Black-Ball", cost: 1}]))
