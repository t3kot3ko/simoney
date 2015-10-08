class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :plans
	has_many :property_fix_histories
	has_many :regular_plans
	has_many :categories

	# TODO: handle `fixed_date` field
	def fix_property(new_property)
		# TODO: these should be executed atmicly
		current = self.property
		if current != new_property
			PropertyFixHistory.create(user: self, new_property: new_property)
			self.update(property: new_property)
		end
	end

	# TODO: remove
	def monthly_transition(s_date = Date.today, e_date = nil)
		today = Date.today
		# begin_date = Date.new(today.year, today.month, 1)
		property = self.property

		monthly_property_transition = []
		(e_date - s_date).to_i.times do |i|
			date = today + i.day
			sum = 0

			# NOTE; too many queries
			planned(s_date, date).each do |_, plans|
				sum += plans.inject(0){|r, ii| r += ii.amount}
			end

			regular_planned(s_date, date).each do |_, plans|
				sum += plans.inject(0){|r, ii| r += ii.amount}
			end

			monthly_property_transition << [date, property + sum]
		end

		return monthly_property_transition
	end

	# TODO: rename
	# all plans planned during s_date ~ e_date
	def planned(s_date, e_date)
		plans = self.plans.order(:planned_at)
			.where("planned_at >= ?", s_date)
			.where("planned_at <  ?", e_date)

		return plans.group_by(&:planned_at)
	end

	# TODO: rename
	def regular_planned(s_date, e_date)
		result = {}
		regular_plans = self.regular_plans.where("start_date <= ?", e_date)

		(e_date - s_date).to_i.times do |i|
			date = s_date + i
			adapted_regular_plans = regular_plans.select{|e| e.adapted? date}

			if adapted_regular_plans.empty?
			else
				result[date] = adapted_regular_plans
			end
		end

		return result
	end

end
