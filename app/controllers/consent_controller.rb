class ConsentController < ApplicationController
  def info_letter
  end

  def screening
    @facebook_response = FacebookResponse.new
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

  def update
    authenticate_with_fb_graph
    check
  end

  # For integration test purposes with Facebook test user accounts who have already approved the app
  def int_check
    session[:facebook_account_number] = params[:facebook_account_number]
    session[:facebook_access_token] = params[:facebook_access_token]
    session[:recruitee_coupon] = params[:recruitee_coupon]
    session[:recruiter_coupon] = params[:recruiter_coupon]
    check
  end

  def check

    @facebook_response = FacebookResponse.find_or_initialize_by(facebook_user_id: facebook_user.id)
    
    fr =  params[:facebook_response]
    
    #recruiter_coupon = SecureRandom.hex(16)
    if @facebook_response.recruiter_coupon?
	recruiter_coupon = @facebook_response.recruiter_coupon
    else
    	recruiter_coupon = SecureRandom.uuid()
    end
    session[:recruiter_coupon] = recruiter_coupon
    @facebook_response.recruiter_coupon = recruiter_coupon
   

    @facebook_response.eighteen_or_older = fr[:eighteen_or_older]
    @facebook_response.gender = fr[:gender]
    @facebook_response.orientation = fr[:orientation]
    @facebook_response.recruitee_coupon = session[:recruitee_coupon]

    #puts "facebook_response.recruiter_coupon = " + @facebook_response.to_yaml
    if @facebook_response.save
      Delayed::Job.enqueue(UpdateServices.new(@facebook_response, facebook_access_token), :priority => 0)
      #UpdateServices.new(@facebook_response, facebook_access_token).perform
      session[:facebook_response_id] =  @facebook_response.id
      redirect_to :controller => "surveyor", :action => "create", :id => @facebook_response.id
    else
      puts "WE BE NOT SAVED"
      puts @facebook_response.errors.messages
      render :invalid
    end
    #puts "FIN"
  end   
   
  private

  def get_friends (facebook_response) 
    facebook_response.facebook_male_friends = save_relationships
    logger.debug "$%$%$%$$$%$%$%$%$%$%$%$%$%$%"
    logger.debug facebook_response.facebook_male_friends
    facebook_response.save()
  end
  #handle_asynchronously :get_friends

  def user_params
    params.require(:redssocs_survey_consent).permit(:eighteen_or_older, :gender, :orientation)
  end

end
