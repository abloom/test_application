class SitesController < ApplicationController
  def new
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    
    if @site.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end
  
  def index
    @sites = Site.all
  end
  
  def show
    @site = Site.find(params[:id])
  end
end
