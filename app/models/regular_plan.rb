class RegularPlan < ActiveRecord::Base
	enum kind: %i(daily weekly monthly yearly)
  belongs_to :user
	belongs_to :category

	# TODO: tentative
	def description
		""
	end

	# TODO: validate to ensure start_date < end_date

	def adapted?(date)
		start_date = self.start_date

		return false if start_date > date

		if end_date && date > end_date
			return false
		end

		if self.daily?
			true
		elsif self.weekly?
			(date - start_date).to_i % 7 == 0
		elsif self.monthly?
			date.day == start_date.day
		elsif self.yearly
			true		# not implemented
		else
			raise "invalid kind"
		end 
	end

	def interval
		if self.daily?
			"毎日"
		elsif self.weekly?
			"毎週"
		elsif self.monthly?
			"毎週"
		elsif self.yearly?
			"毎週"
		else
			raise "invalid kind"
		end 
	end

end
