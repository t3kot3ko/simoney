class Plan < ActiveRecord::Base
	belongs_to :user
	belongs_to :category

	scope :after_today, ->(){where("planned_at >= ?", Date.today)}
end
