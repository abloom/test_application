class PlacementsController < ApplicationController
  def new
    @placement = Placement.new
  end
  
  def create
    @placement = Placement.new(params[:placement])
    
    if @placement.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end
  
  def index
    @placements = Placement.all
  end
  
  def show
    @placement = Placement.find(params[:id])
  end
end
