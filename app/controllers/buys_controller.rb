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
    @buy = filter_and_build(params[:buy])
    @buy.placements.build
    
    f = fields_for("buy", :builder => LabeledBuilder)
    render :partial => "form", :locals => { :f => f }
  end
    
    private
      def filter_and_build(hsh)
        Buy.new(remove_site_conflict!(hsh.dup))
      end
end
