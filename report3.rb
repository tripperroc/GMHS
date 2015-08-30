Response.find_by_sql("select height_feet, height_inches, weight, sex_category,sex_who, sex_feelings,highest_grade_level_completed, income from facebook_responses, responses where responses.facebook_response_id = facebook_responses.id").each() do |respondent|
	if !(respondent.height_feet.nil? || respondent.height_inches.nil? || respondent.weight.nil?)
		printf "%d\t%d\t%d\n", respondent.height_feet, respondent.height_inches, respondent.weight
	end
end

