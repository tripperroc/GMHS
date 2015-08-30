FacebookResponse.all.each do |respondent|
	printf "%s %s %s %s\n", respondent.facebook_user_id, respondent.recruitee_coupon, respondent.recruiter_coupon, respondent.facebook_male_friends
end

FacebookFriendship.all.each do |friendship|
	printf "%s %s\n", friendship.lower_facebook_user_id, friendship.higher_facebook_user_id
end
