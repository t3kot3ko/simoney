class RegularPlan < ActiveRecord::Base
	enum kind: %i(daily weekly monthly yearly)
  belongs_to :user
	belongs_to :category

	def adapted?(date)
		start_date = self.start_date

		return false if start_date > date

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
end
