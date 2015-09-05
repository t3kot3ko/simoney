class User < ActiveRecord::Base
	has_many :plans
	has_many :property_fix_histories
	
	def fix_property(new_property)
		# TODO: these should be executed atmicly
		PropertyFixHistory.create(user: self, new_property: new_property)
		self.update(property: new_property)
	end

end
