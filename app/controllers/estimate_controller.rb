class EstimateController < ApplicationController
  def create
    @estimate = Estimate.find_or_create_by(response_id: params[:id])
    response = Response.find(params[:id])
    @facebook_response = FacebookResponse.find(response.facebook_response_id)
    logger.debug "%%%%%%%%%%%%%%%%%%%%%%%%%%%%" 
    logger.debug @facebook_response
  end

  def update
    params.require(:estimate).permit!   
    @estimate = Estimate.find(params[:id])
    if @estimate.update(params[:estimate])
      redirect_to :controller => "recruit", action: "index", id: @estimate.id
    else 
      logger.debug "%%%%%%%%%%%%%%%%%%%%%%%%%%%%" 
      
      response = Response.find(@estimate.response_id)
      @facebook_response = FacebookResponse.find(response.facebook_response_id)
      render :create 
    end
  end
  
end
