class BuysController < ApplicationController
  helper :buys
  
  def new
    @buy = Buy.new()
  end
  
  def create
    @buy = filter_and_build(params[:buy])
    
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
  
  def add_placement
    @buy = filter_and_build(params[:buy], params[:id])
    @buy.placements.build unless @buy.initialize_placement
    
    render :update do |page|
      page.replace_html "form-fields", :partial => "wrapped_form"      
      page.visual_effect :highlight, "new-placement"
    end
  end
    
    private    
      def filter_and_build(hsh, id = nil)
        buy = if id.blank?
          Buy.new(remove_site_conflict!(hsh.dup))
        else
          buy = Buy.find(id)
          buy.attributes = hsh
          buy
        end
        
        return buy
      end
end
