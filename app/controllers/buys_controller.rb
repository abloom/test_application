class BuysController < ApplicationController
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
    @buy = filter_and_build(params[:buy], params[:originating_action] || "new", params[:buy_id])
    @buy.placements.build unless @buy.initialize_placement
    
    render :update do |page|
      page.replace_html "form-fields", :partial => "wrapped_form"      
      page.visual_effect :highlight, "new-placement"
    end
  end
    
    private    
      def filter_and_build(hsh, orig_action = "new", buy_id = nil)
        case orig_action
        when "new"
          return Buy.new(remove_site_conflict!(hsh.dup))
        when "edit"
          buy = Buy.find(buy_id)
          buy.update_attributes(hsh)
          return buy
        else
          raise "unknown originating action"
        end
      end
end
