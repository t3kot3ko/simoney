class AddEndDateToRegularPlan < ActiveRecord::Migration
  def change
		add_column :regular_plans, :end_date, :date
  end
end
