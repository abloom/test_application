ActionController::Routing::Routes.draw do |map|
  map.root :controller => "application", :action => "home"
  map.resources :sites
  map.resources :plans, :collection => ["add_placement", "add_buy"]
  map.resources :buys, :collection => "add_placement"
  map.resources :placements
end
