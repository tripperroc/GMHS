class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z\.0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class FacebookResponse < ActiveRecord::Base
  belongs_to :facebook_user
  #belongs_to :response_set

  validate :has_fewer_than_ten_seeds, :has_fewer_than_three_recruits, :recruiter_exists, :shares_sexual_orientation, :still_sampling, on: :create 
  validate :not_recruitment
  
  @@sample_size = 9
  @@num_seeds = 1

  def has_fewer_than_ten_seeds
    if recruitee_coupon == "585" && (((orientation == "Gay" || orientation == "Bisexual") && FacebookResponse.where(recruitee_coupon: "585", orientation: "Gay").count +  FacebookResponse.where(recruitee_coupon: "585", orientation: "Bisexual").count >= @@num_seeds) || (orientation == "Heterosexual" && FacebookResponse.where(recruitee_coupon: "585", orientation: "Heterosexual").count >= @@num_seeds))
      errors.add(:recruitee_coupon, "Cannot have more than ten seeds")
     
    end
  end
  
  def has_fewer_than_three_recruits
    if recruitee_coupon != "814" && recruitee_coupon != "585" && FacebookResponse.where(recruitee_coupon: recruitee_coupon).count >= 3
      errors.add(:recruitee_coupon, "Cannot have more than three recruits")
    end
  end

  def recruiter_exists
    if recruitee_coupon != "814" && recruitee_coupon != "585" && FacebookResponse.where(recruiter_coupon: recruitee_coupon).count == 0
      errors.add(:recruitee_coupon, "Invalid coupon")
    end
  end

  def not_recruitment
    if recruitee_coupon != "814" 
     # puts "facebook_user_id: " + facebook_user_id.to_s
      #caller.each {|s| puts s if s.include? ("/Users/cmh/GMHS/app") }
      r = FacebookResponse.find_by(facebook_user_id: facebook_user_id)
      if r
        #puts "old: " + r.recruitee_coupon + "; new: " + recruitee_coupon
        if r.recruitee_coupon != recruitee_coupon
          errors.add(:recruitee_coupon, "Already recruited")
        end
      end
    end
  end
  
  def shares_sexual_orientation 
    if recruitee_coupon != "814" && recruitee_coupon != "585"
      s = FacebookResponse.find_by(recruiter_coupon: recruitee_coupon)
      if !s.nil? 
	if (s.orientation == "Heterosexual" && orientation != s.orientation)  || ((s.orientation == "Gay" || s.orientation == "Bisexual") && orientation != "Gay" && orientation != "Bisexual")
          errors.add(:orientation, "Incompatible orientations")
	end
      end
    end
  end

  def still_sampling
    if recruitee_coupon != "814" && (((orientation == "Gay" || orientation == "Bisexual") && FacebookResponse.where(orientation: "Gay").count +  FacebookResponse.where(orientation: "Bisexual").count >= @@sample_size) || (orientation == "Heterosexual" && FacebookResponse.where(orientation: "Heterosexual").count >= @@sample_size))
      errors.add(:recruiter_coupon, "Sample size is reached")
    end
  #validates :email_address, presence: true, email: true
  end
end
