set :application,           "peopleask"
set :domain,                "sh1.flatsoft.ru"

set :rails_env,             ENV['ENV'] ? ENV['ENV'] : "production"

set :deploy_to,             "/var/www/rails/#{application}/#{rails_env}"
set :repository,            "git@git.flatsoft.ru:prj/#{application}.git"

set :mongrel_command,       "sudo mongrel_rails"
set :mongrel_conf,          "/etc/rails/mongrel_cluster/#{application}_#{rails_env}.conf"
set :mongrel_user,          "rails"
set :mongrel_group,         "rails"
set :mongrel_clean,         true
set :mongrel_environment,   "#{rails_env}"
set :mongrel_port,          "#{rails_env}" == "production" ? "9500" : "8500"

set :rake_cmd,              "sudo -u #{mongrel_user} rake"