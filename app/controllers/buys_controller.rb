class BuysController < ApplicationController
  def new
    @buy = Buy.new()
    @buy.build_site
  end
  
  def create
    buy_params = params[:buy]
    if buy_params[:site_attributes][:id].blank?
      buy_params[:site_attributes].delete(:id)
    else
      buy_params[:site_attributes].delete(:name)
      buy_params[:site_attributes].delete(:url)
      buy_params[:site_attributes].delete(:billing_contact)
    end
    
    logger.debug buy_params.inspect
    @buy = Buy.new(buy_params)
    
    if @buy.save
      redirect_to root_path
    else
      @buy.build_site unless @buy.site
      render :action => "new"
    end
  end
end
