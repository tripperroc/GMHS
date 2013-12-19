class ConsentController < ApplicationController

  def info_letter

    if request.post?
#      if @rsc =  RedssocsSurveyConsent.create(params[:redssocs_survey_consent])
      if @rsc =  RedssocsSurveyConsent.create(user_params)
        if !@rsc.eligible?
          redirect_to :action => 'not_eligible'
        end 
      else
         redirect_to :action => 'not_eligible'
      end
    else 
      redirect_to :action => 'index'
    end
  end

  def index
    @rsc = RedssocsSurveyConsent.new
    @recruitee_coupon = session[:recruitee_coupon]
  end

  def not_eligible
  end
 
  def wrong_coupon
    @original_url = url_for :controller => 'recruit', :action => 'invitation', :id => session[:original_coupon]
    @wrong_url = url_for :controller => 'recruit', :action => 'invitation', :id => session[:recruitee_coupon]  
  end

  def expired 
    @coupon_url  = url_for :controller => 'recruit', :action => 'invitation', :id => session[:recruitee_coupon]
  end

  def invalid
    @coupon_url  = url_for :controller => 'recruit', :action => 'invitation', :id => session[:recruitee_coupon]    
  end

  private

  def user_params
    params.require(:redssocs_survey_consent).permit(:eighteen_or_older, :gender, :orientation)
  end

end
