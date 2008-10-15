# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
    def title
        APP_CONFIG['app_name']
    end

end
