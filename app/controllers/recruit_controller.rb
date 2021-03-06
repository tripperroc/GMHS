class RecruitController < ApplicationController

  #layout "recruit"

  def index   
   
    #estimate = Estimate.find(params[:id])
    #response = Response.find (estimate.response_id)
    response = Response.find (params[:id])
    @facebook_response = FacebookResponse.find(response.facebook_response_id)
    @invitation_url = url_for :controller => 'recruit', :action => 'invitation', :id => @facebook_response.recruiter_coupon
    @email = @facebook_response.email_address
    #@male_facebook_friends = session[:total_male_friends]
    @recruitee_coupon =  @facebook_response.recruiter_coupon
    #@gay_facebook_friends = estimate.facebook_gay_friends
    if (params[:direction] && params[:direction] == "B")
      redirect_to :controller => :surveyor, :action => :create, id: @facebook_response.id
    else
      ResponderMailer.thank_you_email({:invitation_url => @invitation_url, :email_address => @email, :orientation => @facebook_response.orientation}).deliver
    end
  end

  def loginvitation 
    logger.debug ("a;sldfkas;dlfkajs;dlfkajsd;lfkasjdfl;askjdf;lsakjdfa;slkdjfas;ldkfjas;ldf")
    logger.debug params
    facebook_user = FacebookUser.find_by(:facebook_account_number => params[:facebook_account_number])
    begin
      FacebookResponse.find_by!(:facebook_user_id => facebook_user.id)
    rescue ActiveRecord::RecordNotFound
      logger.debug ("345345345345345345345345345345345345345345345345345")
      logger.debug ("We're rescuing!!!")
      facebook_response = FacebookResponse.create(:facebook_user_id => facebook_user.id, :recruitee_coupon => params[:recruitee_coupon])
    end
  end

  def invitation
    session[:recruitee_coupon] = params[:id]
    redirect_to :controller => 'consent', :action => 'index' #, :id => params[:id]
  end

  def email
    session[:email] = params[:email]
    render :json => { "mmail" => params[:email] }
 
  end

end
