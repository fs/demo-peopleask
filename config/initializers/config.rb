APP_CONFIG = YAML.load(File.read(Rails.root + "/config/app.yml"))[RAILS_ENV]
