module ActionController
  module Caching
    module Actions
      class ActionCacheFilter
        def caching_allowed_with_post(controller)
          (controller.request.get? || controller.request.post? && controller.request.xhr?) &&
            controller.response.headers['Status'].to_i == 200
        end
        alias_method_chain :caching_allowed, :post
      end
    end
  end
end