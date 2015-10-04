class AddCategoryIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :category_id, :integer
		remove_column :plans, :category
  end
end
