set :application,   "peopleask"
set :domain,        "flatsoft-rails.flatsoft.ru"
set :app_domain,    "peopleask.ru"
set :only_www,      true
set :environment,   "production"
set :deploy_to,     "/var/www/rails/#{application}/#{environment}"
set :repository,    "git@github.com:fs/demo-#{application}.git"
