class AddCategoryIdToRegularPlans < ActiveRecord::Migration
  def change
    add_column :regular_plans, :category_id, :integer
		remove_column :regular_plans, :category

  end
end
