class BuysController < ApplicationController
  def new
    @buy = Buy.new()
    @buy.build_site
  end
  
  def create
    buy_params = params[:buy].dup
    if buy_params[:site_id].blank?
      buy_params.delete(:site_id)
    else
      buy_params.delete(:site_attributes)
    end
    
    @buy = Buy.new(buy_params)
    
    if @buy.save
      redirect_to root_path
    else
      @buy.build_site unless @buy.site
      render :action => "new"
    end
  end
  
  def index
    @buys = Buy.all
  end
  
  def show
    @buy = Buy.find(params[:id])
  end
  
  def edit
    @buy = Buy.find(params[:id])
  end
  
  def update
    @buy = Buy.find(params[:id])
    
    if @buy.update_attributes(params[:buy])
      redirect_to root_path
    else
      render :action => "edit"
    end
  end
end
