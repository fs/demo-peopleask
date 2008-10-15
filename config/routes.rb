ActionController::Routing::Routes.draw do |map|
  map.resources :questions
    
  ## public part
  map.root :controller => 'questions'
end
