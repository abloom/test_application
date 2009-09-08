class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end
  
  def new
    @plan = Plan.new
  end
  
  def create
    @plan = Plan.new(params[:plan])
    
    if @plan.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end
  
  def show
    @plan = Plan.find(params[:id])#, :include => { :buys => [:site, :placements] })
  end
  
  def edit
    @plan = Plan.find(params[:id])
  end
  
  def update
    @plan = Plan.find(params[:id])
    
    if @plan.update_attributes(params[:plan])
      redirect_to root_path
    else
      render :action => "edit"
    end
  end
end
