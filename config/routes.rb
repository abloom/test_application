ActionController::Routing::Routes.draw do |map|
  map.root :controller => "application", :action => "home"
  map.resources :sites
  map.resources :plans, :new => ["add_placement", "add_buy"], :member => ["add_placement", "add_buy"]
  map.resources :buys, :new => "add_placement", :member => "add_placement"
  map.resources :placements
end
