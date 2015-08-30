FacebookResponse.all.each do |respondent|
  response = Response.where(facebook_response_id: respondent.id).first
  estimate = Estimate.where(response_id: response.id).first
  unless estimate.nil? || estimate.email_address.nil?
    puts estimate.email_address, respondent.recruiter_coupon
    ResponderMailer.reminder_email({email_address: estimate.email_address, invitation_url: ("https://chiron.urmc.rochester.edu/recruit/invitation/" + respondent.recruiter_coupon)}).deliver
    #ResponderMailer.payment_email({email_address: estimate.email_address, invitation_url: ("https://chiron.urmc.rochester.edu/recruit/invitation/" + respondent.recruiter_coupon)}).deliver
    #ResponderMailer.reminder_email({email_address: "cmh@cs.rit.edu", invitation_url: ("https://chiron.urmc.rochester.edu/recruit/invitation/" + respondent.recruiter_coupon)}).deliver
    #ResponderMailer.payment_email({email_address: "cmh@cs.rit.edu", invitation_url: ("https://chiron.urmc.rochester.edu/recruit/invitation/" + respondent.recruiter_coupon)}).deliver
  end
end
