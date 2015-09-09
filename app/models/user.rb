class User < ActiveRecord::Base
	has_many :plans
	has_many :property_fix_histories
	has_many :regular_plans
	
	def fix_property(new_property)
		# TODO: these should be executed atmicly
		PropertyFixHistory.create(user: self, new_property: new_property)
		self.update(property: new_property)
	end

	def monthly_transition
		today = Date.today
		begin_date = Date.new(today.year, today.month, 1)
		end_date = begin_date + 1.month
		property = self.property

		monthly_property_transition = []
		(end_date - today).to_i.times do |i|
			date = today + i.day
			sum = planned(begin_date, date).inject(0){|r, ii| r += ii.amount}
			monthly_property_transition << [date, property + sum]
		end

		return monthly_property_transition
	end

	
	# all plans planned during s_date ~ e_date (including RegularPlan)
	def planned(s_date, e_date)
		plans = self.plans.order(:planned_at)
			.where("planned_at >= ?", s_date)
			.where("planned_at <  ?", e_date)

		return plans
	end

	# TODO: consider return format
	def regular_planned(s_date, e_date)
		result = {}
		regular_plans = self.regular_plans.where("start_date >= ?", s_date)

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
