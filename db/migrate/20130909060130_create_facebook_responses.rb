class CreateFacebookResponses < ActiveRecord::Migration
  def self.up
    create_table :facebook_responses do |t|
      # Context
      t.integer :facebook_user_id
      t.integer :recruit_id

      # Content
      t.string :recruitee_coupon
      t.string :recruiter_coupon
      t.string :email_address

      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_surveys
  end
end
