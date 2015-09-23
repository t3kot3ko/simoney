module RegularPlansHelper
	def interval_string(rp)
		s = rp.start_date.to_s + " から "

		s += 
			case rp.kind
			when "daily"
				"毎日"
			when "monthly"
				"毎月"
			when "weekly"
				"毎週"
			when "yearly"
				"毎年"
			end

		return s
	end
end
