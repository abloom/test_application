class PlansController < ApplicationController
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
end
