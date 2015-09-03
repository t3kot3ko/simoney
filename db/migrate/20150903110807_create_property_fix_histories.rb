class CreatePropertyFixHistories < ActiveRecord::Migration
  def change
    create_table :property_fix_histories do |t|
      t.belongs_to :user, index: true
      t.integer :new_property

      t.timestamps null: false
    end
    add_foreign_key :property_fix_histories, :users
  end
end
