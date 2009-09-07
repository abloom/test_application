ActionController::Routing::Routes.draw do |map|
  map.root :controller => "application", :action => "home"
  map.resources :sites
  map.resources :plans, :member => "add_buy"
  map.resources :buys
  map.resources :placements
end
