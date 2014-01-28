class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :response_id
      t.integer :facebook_male_friends
      t.integer :facebook_gay_friends
      t.string :accuracy
      t.integer :right_percentage
      t.string :how_recruited
      t.string :email_address
      
      t.timestamps
    end
  end
end
