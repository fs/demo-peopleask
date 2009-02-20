ActionController::Routing::Routes.draw do |map|
  map.resources :questions
  map.root :controller => 'questions'
  map.question ':question', :controller => 'questions', :action => 'index'
end
