class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :facebook_response_id
      t.string :recruitee_coupon
      t.string :recruiter_coupon
      t.string :email_address
      t.integer :age
      t.string :birth_sex
       t.string :sexual_orientation
      t.string :hispanic
      t.string :healthcare_delayed
      t.string :hundred_cigarettes
      t.string :frequency_cigarettes
      t.string :worried
      t.string :depressed
      t.string :suicide
      t.integer :alcohol
      t.integer :facebook_gay_friends
      t.integer :screening_id
      t.timestamps
    end
  end
end
