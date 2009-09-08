# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  layout "default"
  
  def remove_site_conflict!(hsh)
    if hsh["site_id"].blank?
      hsh.delete("site_id")
    else
      hsh.delete("site_attributes")
    end
    
    return hsh
  end
end
