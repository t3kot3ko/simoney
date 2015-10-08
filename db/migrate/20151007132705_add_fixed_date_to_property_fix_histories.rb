class AddFixedDateToPropertyFixHistories < ActiveRecord::Migration
  def change
    add_column :property_fix_histories, :fixed_date, :date
  end
end
