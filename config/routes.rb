ActionController::Routing::Routes.draw do |map|
  map.rubyamf_gateway 'rubyamf_gateway', :controller => 'rubyamf', :action => 'gateway'

  map.split '/stories/split/:id', :controller => 'stories', :action => 'split'
  map.split_format '/stories/split/:id.:format', :controller => 'stories', :action => 'split'
  
  map.resources :stories do |stories|
    stories.resources :tasks
  end

  map.resources :iterations do |iterations|
    iterations.resources :stories
  end

  map.resources :releases
  map.resources :individuals
  map.resources :projects
  map.resources :surveys

  map.resource :session
  map.resource :system
  map.activate '/activate/:activation_code', :controller => 'individuals', :action => 'activate'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  #map.connect '', :controller => 'stories', :action => 'index'
  
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  # map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  # map.connect ':controller/:action/:id.:format'
  # map.connect ':controller/:action/:id'
end