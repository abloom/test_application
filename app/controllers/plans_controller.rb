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
    @plan = Plan.find(params[:id])
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
  
  def add_buy
    render :file => File.join(Rails.public_path, "404.html") unless request.xhr?
    
    buy = Buy.find(params[:buy_id])
    render :partial => "buys_form", :locals => { :buy => buy }
  end
end
