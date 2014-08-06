module NeopolyStyle
  module ApplicationHelperPatch
    def self.included(target)
      target.send(:include, InstanceMethods)

      target.class_eval do
        alias_method_chain :favicon_path, :neopoly_style
      end
    end

    module InstanceMethods
      def favicon_path_with_neopoly_style
        path = '/plugin_assets/neopoly_style/images/favicon.ico'
        image_path(path)
      end
    end
  end

  ApplicationHelper.send(:include, ApplicationHelperPatch)
end
