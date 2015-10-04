# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User
User.destroy_all

u = User.create(name: "test", email: "test@example.com", password: "12345678", property: 10000)
u.plans.destroy_all
u.regular_plans.destroy_all

# Category
10.times do |i|
	u.categories << Category.new(user: u, name: "category#{i.to_s}")
end

# Plan
today = Date.today
this_month_first = today - today.day + 1
this_month_last  = this_month_first + 1.month - 1

seed = [-1000, -2000, -3000, -4000]
10.times do
	Plan.create(user_id: u.id, amount: seed.sample, planned_at: today + rand(10), category: u.categories.sample)
end

# Regular plan

# monthly
RegularPlan.create(user: u, kind: :monthly, category: u.categories.sample, amount: 200000, start_date: this_month_first + 25)
RegularPlan.create(user: u, kind: :monthly, category: u.categories.sample, amount: -15000, start_date: this_month_first + 10)

# Weekly
RegularPlan.create(user: u, kind: :weekly, category: u.categories.sample, amount: 4000, start_date: this_month_first)

# Daily
RegularPlan.create(user: u, kind: :daily, category: u.categories.sample, amount: 100 + rand(100), start_date: this_month_first)
