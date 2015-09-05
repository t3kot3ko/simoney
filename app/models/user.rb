class User < ActiveRecord::Base
	has_many :plans
	has_many :property_fix_histories
	
	def fix_property(new_property)
		# TODO: these should be executed atmicly
		PropertyFixHistory.create(user: self, new_property: new_property)
		self.update(property: new_property)
	end

	def monthly
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

	def planned(s_date, e_date)
		plans = self.plans.order(:planned_at)
			.where("planned_at >= ?", s_date)
			.where("planned_at <  ?", e_date)
		return plans
	end

end
