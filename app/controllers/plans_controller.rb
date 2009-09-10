class PlansController < ApplicationController
  helper :plans
  
  def index
    @plans = Plan.all
  end
  
  def new
    @plan = Plan.new
  end
  
  def create
    @plan = filter_and_build(params[:plan])
    
    if @plan.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end
  
  def show
    @plan = Plan.find(params[:id], :include => { :buys => [:site, :placements] })
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
    @plan = filter_and_build(params[:plan], params[:id])
    @plan.buys.build unless @plan.initialize_buy
    
    render :update do |page|
      page.replace_html "form-fields", :partial => "wrapped_form"      
      page.visual_effect :highlight, "new-buy"
    end
  end
  
  def add_placement
    @plan = filter_and_build(params[:plan], params[:id])
    buy = @plan.buys[params[:buy_index].to_i]
    buy.placements.build unless !buy.nil? && buy.initialize_placement
    
    render :update do |page|
      page.replace_html "form-fields", :partial => "wrapped_form"
      page.visual_effect :highlight, "new-placement"
    end
  end
  
  private
    def filter_and_build(hsh, id = nil)
      plan = if id.blank?
        plan_params = hsh.dup
        (plan_params["buys_attributes"] || {}).each do |key, value|
          remove_site_conflict!(value)
        end
        Plan.new(plan_params)
      else
        plan = Plan.find(id)
        plan.attributes = hsh
        plan
      end
      
      return plan
    end
end
