Redmine::Plugin.register :http_basic_authorization do
  name "Http Basic Authorization plugin"
  author "Jonas Thiel"
  description "This plugin uses HTTP basic authentication headers for login" \
              " and IMPLICIT registration!"
  version "0.0.1"
  url "http://www.neopoly.de"
  author_url "http://www.neopoly.de"

  ActionDispatch::Callbacks.to_prepare do
    require "http_basic_authorization"
  end

  settings default: { "email_suffix" => "@neopoly.de" },
           partial: "http_basic_authorization/settings"
end

RedmineApp::Application.config.after_initialize do
  unless ApplicationController.include?(HttpBasicAuthorization::ApplicationControllerPatch)
    ApplicationController.send(:include, HttpBasicAuthorization::ApplicationControllerPatch)
  end
  unless AccountController.include?(HttpBasicAuthorization::AccountControllerPatch)
    AccountController.send(:include, HttpBasicAuthorization::AccountControllerPatch)
  end
end
