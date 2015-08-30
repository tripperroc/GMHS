FacebookResponse.all.each do |respondent|
	counts = FacebookFriendship.where(lower_facebook_user_id: respondent.facebook_user_id).count + FacebookFriendship.where(higher_facebook_user_id: respondent.facebook_user_id).count
	if counts < 15
		printf "%s %s %s %s %d\n", respondent.facebook_user_id, respondent.recruitee_coupon, respondent.recruiter_coupon, respondent.facebook_male_friends, counts
		response = Response.where(facebook_response_id: respondent.id).first
		estimate = Estimate.where(response_id: respondent.id).first
  		unless estimate.nil? || estimate.email_address.nil?
    			puts estimate.email_address, respondent.recruiter_coupon
    			ResponderMailer.bogus_email({email_address: estimate.email_address}).deliver
		end
        end
end


