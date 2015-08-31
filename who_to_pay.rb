printf "email\tfacebook_id\trecruitee_coupon\trecruiter_coupon\tfacebook_male_friends\ttotal_fb_friends\ttotal_recuits\tamt_owed\n"
FacebookResponse.all.each do |respondent|
	counts = FacebookFriendship.where(lower_facebook_user_id: respondent.facebook_user_id).count + FacebookFriendship.where(higher_facebook_user_id: respondent.facebook_user_id).count
	if counts >= 15
		response = Response.where(facebook_response_id: respondent.id).first
		estimate = Estimate.where(response_id: respondent.id).first
  		unless estimate.nil? || estimate.email_address.nil?
  				recruitees = FacebookResponse.where(recruitee_coupon: respondent.recruiter_coupon).count
  				amt_owed = 15 + 15 * recruitees
  			    printf "%s\t%s\t%s\t%s\t%s\t%d\t%d\t%d\n", estimate.email_address, respondent.facebook_user_id, respondent.recruitee_coupon, respondent.recruiter_coupon, respondent.facebook_male_friends, counts, recruitees, amt_owed
	
    		
		end
    end
end

