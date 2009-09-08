class BuysController < ApplicationController
  def new
    @buy = Buy.new()
    @buy.build_site
    @buy.placements.build
  end
  
  def create
    buy_params = remove_site_conflict!(params[:buy].dup)
    @buy = Buy.new(params[:buy])
    
    if @buy.save
      redirect_to root_path
    else
      @buy.build_site unless @buy.site
      @buy.placements.build if @buy.placements.empty?
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
