class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :user
      t.string :category
      t.integer :amount
      t.date :planned_at

      t.timestamps null: false
    end
  end
end
