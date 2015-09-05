class CreateRegularPlans < ActiveRecord::Migration
  def change
    create_table :regular_plans do |t|
      t.belongs_to :user, index: true
      t.string :category
      t.integer :amount
      t.date :start_date
      t.integer :kind

      t.timestamps null: false
    end
    add_foreign_key :regular_plans, :users
  end
end
