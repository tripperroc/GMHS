class CreateFronts < ActiveRecord::Migration
  def change
    create_table :fronts do |t|

      t.timestamps
      t.string :recruitee_coupon
    end
  end
end
