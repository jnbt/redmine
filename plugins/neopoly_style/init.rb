Redmine::Plugin.register :neopoly_style do
  name "Neopoly Stylesheets"
  author "Jonas Thiel"
  description "Custom style overrides"
  version "0.0.1"
  url "http://www.neopoly.de"
  author_url "http://www.neopoly.de"

  ActionDispatch::Callbacks.to_prepare do
    require "neopoly_style_application_hooks"
  end
end