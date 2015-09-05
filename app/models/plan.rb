class Plan < ActiveRecord::Base
	belongs_to :user

	scope :after_today, ->(){where("planned_at >= ?", Date.today)}
end
