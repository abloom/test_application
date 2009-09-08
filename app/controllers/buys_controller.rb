class BuysController < ApplicationController
  def new
    @buy = Buy.new()
  end
  
  def create
    buy_params = remove_site_conflict!(params[:buy].dup)
    @buy = Buy.new(buy_params)
    
    if @buy.save
      redirect_to root_path
    else
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
    @buy = Buy.find(params[:id], :include => [:placements])
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
