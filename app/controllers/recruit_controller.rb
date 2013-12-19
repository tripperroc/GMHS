class RecruitController < ApplicationController

  layout "recruit"

  def index   
    @invitation_url = url_for :controller => 'recruit', :action => 'invitation', :id => session[:recruiter_coupon]
    @email = session[:email_address]
    @male_facebook_friends = session[:total_male_friends]

    params.require(:estimate).permit!   
    estimate = Estimate.find(params[:id])
    estimate.update_attributes!(params[:estimate])
   
    #logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #logger.debug q.id
    #logger.debug session[:response_set]
    
    #r = Response.find(estimate.response_id)
    @gay_facebook_friends = estimate.facebook_gay_friends
    ResponderMailer.thank_you_email({:invitation_url => @invitation_url, :email_address => @email}).deliver
  end

  def invitation
    session[:recruitee_coupon] = params[:id]
    redirect_to :controller => 'consent', :action => 'index'
  end

  def email
    session[:email] = params[:email]
    render :json => { "mmail" => params[:email] }
 
  end

end
