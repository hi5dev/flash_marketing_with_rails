class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :call_to_action
      t.boolean :active

      t.timestamps
    end
  end
end
